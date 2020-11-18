package tib.eu.tibportaltools;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.StringReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

/**
 * Class to generate training data for annif from oai-files containing documents in ftx-format (s.
 * https://wiki.tib.eu/jira/browse/PORTALE-11525). From xml-files containing ftx harvested via oai
 * (e.g. ../../../doc/annif/example-files/oai-harvested-ftx.xml) 3 files are generated for every
 * ftx-document: 1. txt-file containen the ftx-document (e.g.
 * ../../../doc/annif/example-files/ftx.txt),2. tsv-file containing gnd-subjects (e.g.
 * ../../../doc/annif/example-files/gnd.txt), 3. tsv-file containing bk-classes (e.g.
 * ../../../doc/annif/example-files/bk.txt) Each type of file will be stored in its own directory
 * (output-directory passed to main method + /FTX or /GND or /BK)
 */
public class AnnifTrainingDataGeneration {

  /**
   * enum for each filetype for indicating file extension and output directory.
   */
  private enum DataType {
    FTX("txt"), GND("tsv"), BK("tsv");
    private String fileExtension;

    DataType(String extension) {
      fileExtension = extension;
    }

    public String getFileExtension() {
      return fileExtension;
    }
  }

  /**
   * pattern to extract ftx-documnts from oai-files
   */
  private Pattern metadataPattern = Pattern.compile("<metadata>(.+?)</metadata>", Pattern.DOTALL);

  private XPathFactory xpathFactory;
  /**
   * pattern to extract subjects with gnd from ftx-file
   */
  private XPathExpression exprSubjectWithGnd;
  /**
   * pattern to extract classifications with bk from ftx-file
   */
  private XPathExpression exprClassificationBk;
  private DocumentBuilder documentBuilder;

  public AnnifTrainingDataGeneration() throws XPathExpressionException,
      ParserConfigurationException {
    xpathFactory = XPathFactory.newInstance();
    exprSubjectWithGnd = xpathFactory.newXPath().compile("//subject[@type='gnd']");
    exprClassificationBk = xpathFactory.newXPath().compile(
        "//classification[@classificationName='bk']");
    documentBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
  }

  /**
   * @param args args[0]: absolute path to directory containing oai-xml-files with ftx, args[1]:
   * outputdirectory for generated annif training data files
   * @throws IOException
   * @throws XPathExpressionException
   * @throws ParserConfigurationException
   */
  public static void main(String[] args) throws IOException, XPathExpressionException,
      ParserConfigurationException {
    String pathToSourceDirectory = "/home/deckert/annif/fid-move-ftx-dump";
    String pathToOutputDir = "/home/deckert/annif/output";
    if (args.length == 2) {
      pathToSourceDirectory = args[0];
      pathToOutputDir = args[1];
    }
    System.out.println("start reading files from " + pathToSourceDirectory
        + " generating files in directory " + pathToOutputDir);
    new AnnifTrainingDataGeneration().processFiles(pathToSourceDirectory, pathToOutputDir);
    System.out.println("end");
  }

  /**
   * @param pathToSourceDirectory: absolute path to directory containing oai-xml-files with ftx
   * @param pathToOutputDir: outputdirectory for generated annif training data files
   * @throws IOException
   */
  public void processFiles(String pathToSourceDirectory, String pathToOutputDir)
      throws IOException {

    try (Stream<Path> walk = Files.walk(Paths.get(pathToSourceDirectory))) {
      List<String> result = walk.map(Path::toString)
          .filter(f -> f.endsWith(".xml")).collect(Collectors.toList());
      result.forEach((String path) -> {
        try {
          processFile(path, pathToOutputDir);
        } catch (Exception e) {
          e.printStackTrace();
        }
      });

    }
  }

  private void processFile(String pathToFile, String pathToOutputDir) throws FileNotFoundException,
      IOException, ParserConfigurationException, SAXException, XPathExpressionException {
    String content = new String(Files.readAllBytes(Paths.get(pathToFile)));
    Matcher matcher = metadataPattern.matcher(content);
    while (matcher.find()) {
      String group = matcher.group(1);
      writeTrainingFiles(group, pathToOutputDir);
    }

  }

  private void writeTrainingFiles(String ftx, String outputDir) throws ParserConfigurationException,
      SAXException, IOException, XPathExpressionException {

    Document document = documentBuilder.parse(new InputSource(new StringReader(ftx)));

    NamedNodeMap atts = (document.getElementsByTagName("document")).item(0).getAttributes();
    String id = atts.getNamedItem("id").getNodeValue();
    writeDataFile(id, ftx, outputDir, DataType.FTX);

    StringBuilder sortedGnds = getGndData(document);
    writeDataFile(id, sortedGnds.toString(), outputDir, DataType.GND);

    StringBuilder sortedBks = getBkData(document);
    writeDataFile(id, sortedBks.toString(), outputDir, DataType.BK);

  }

  /**
   * Extracts bk from document generating strings containing lines e.g. <http://uri.gbv.de/terminology/bk/55.40>  Schiffstechnik, Schiffbau
   * @param document
   * @return
   * @throws XPathExpressionException
   */
//   private StringBuilder getBkData(Document document) throws XPathExpressionException {
//     NodeList nodes = (NodeList) exprClassificationBk.evaluate(document, XPathConstants.NODESET);
//     List<String> bks = new ArrayList<>();
//     for (int i = 0; i < nodes.getLength(); i++) {
//       StringBuilder bk = new StringBuilder();
//       Node node = nodes.item(i);
//       NodeList childs = node.getChildNodes();
//       StringBuilder labels = new StringBuilder();
//       for (int k = 0; k < childs.getLength(); k++) {
//         Node child = childs.item(k);
//         if (child.getNodeName().equalsIgnoreCase("code")) {
//           bk.append("<http://uri.gbv.de/terminology/bk/").append(child.getTextContent()).append(
//               ">");
//         } else if (child.getNodeName().equalsIgnoreCase("entries")) {
//           NodeList entries = child.getChildNodes();
//           for (int l = 0; l < entries.getLength(); l++) {
//             Node entry = entries.item(l);
//             if (entry.getNodeName().equals("entry")) {
//               if (labels.length() > 0) {
//                 labels.append('\t');
//               }
//               labels.append(entry.getTextContent());
//             }
//           }
//         }
//       }
//       if (labels.length() > 0) {
//         bk.append('\t').append(labels);
//       }
//       bks.add(bk.toString());
//     }
//     return getSortedData(bks);
//   }

//   private StringBuilder getSortedData(List<String> bks) {
//     Collections.sort(bks);
//     StringBuilder sortedBks = new StringBuilder();
//     for (String bkString : bks) {
//       sortedBks.append(bkString).append("\n");
//     }
//     return sortedBks;
//   }
  /**
   * Extracts dnd subjects from document generating strings containing lines e.g. <https://d-nb.info/gnd/4027833-5> Italien
   * @param document
   * @return
   * @throws XPathExpressionException
   */
//   private StringBuilder getGndData(Document document) throws XPathExpressionException {
//     NodeList nodes = (NodeList) exprSubjectWithGnd.evaluate(document, XPathConstants.NODESET);
//     List<String> gnds = new ArrayList<>();
//     for (int i = 0; i < nodes.getLength(); i++) {
//       Node node = nodes.item(i);
//       StringBuilder gnd = new StringBuilder();
//       gnd.append("<https://d-nb.info/gnd/").append(node.getAttributes().getNamedItem("id")
//           .getNodeValue()).append(">");
//       NodeList childs = node.getChildNodes();
//       for (int k = 0; k < childs.getLength(); k++) {
//         Node child = childs.item(k);
//         if (child.getNodeName().equalsIgnoreCase("dc:subject")) {
//           gnd.append('\t').append(child.getTextContent());
//         }
//       }
//       gnds.add(gnd.toString());
//     }
//     return getSortedData(gnds);
//   }

  private void writeDataFile(String id, String data, String outputDir, DataType dataType)
      throws IOException {
    File outputDirectory = new File(outputDir, dataType.name());
    ;
    if (!outputDirectory.exists()) {
      Path path = Paths.get(outputDirectory.toURI());
      Files.createDirectories(path);
    }
    try (FileOutputStream outputStream = new FileOutputStream(new File(outputDirectory
        .getAbsolutePath(), id
            + "." + dataType.getFileExtension()))) {
      byte[] strToBytes = data.getBytes();
      outputStream.write(strToBytes);
    }
  }

}
