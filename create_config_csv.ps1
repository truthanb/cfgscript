$csvFile = import-csv -Path "C:\Users\Btruthan\Desktop\Book1.csv"
$xmlPath = "C:\Users\Btruthan\Desktop\XML2.xml"


$xmlWriter = New-Object System.Xml.XmlTextWriter($xmlPath, $null)
$xmlWriter.Formatting = 'Indented'
$xmlWriter.Indentation = 1
$XmlWriter.IndentChar = "`t"
$xmlWriter.WriteStartDocument()
$xmlWriter.WriteStartElement('Imports')
$xmlWriter.WriteEndElement()
$xmlWriter.WriteEndDocument()
$xmlWriter.Flush()
$xmlWriter.Close()

$xmlDoc = [System.Xml.XmlDocument](Get-Content $xmlPath);
$i=0
for ($i; $i -lt $csvFile.Length; $i++)
    { 
        $row = $csvFile[$i]
        $deviceNode = $xmlDoc.CreateElement("Device")
        $nameNode = $xmlDoc.CreateElement("DeviceName")
        $nameNode.InnerText = $row.Name
        $modelNode = $xmlDoc.CreateElement("DeviceModel")
        $modelNode.InnerText = $row.Model
        $serialNode = $xmlDoc.CreateElement("DeviceSerialNumber")
        $serialNode.InnerText = $row.Serial
        $typeNode = $xmlDoc.CreateElement("RtuType")
        $typeNode.InnerText = $row.Type
        $addressNode = $xmlDoc.CreateElement("DNPAddress")
        $addressNode.InnerText = $row.Address
        $locationNode = $xmlDoc.CreateElement("LocationId")
        $locationNode.InnerText = $row.Location
        $deviceNode.AppendChild($nameNode)
        $deviceNode.AppendChild($modelNode)
        $deviceNode.AppendChild($serialNode)
        $deviceNode.AppendChild($typeNode)
        $deviceNode.AppendChild($addressNode)
        $deviceNode.AppendChild($locationNode)
        $xmlDoc.SelectSingleNode("//Imports").AppendChild($deviceNode)

        $xmlDoc.Save($xmlPath)
    }
