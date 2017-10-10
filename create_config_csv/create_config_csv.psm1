function Set-ConfigFromCsv {

    <#
    .SYNOPSIS
    Sets xml config for devices with from a csv file
    .DESCRIPTION
    Takes Name, Model, Serial, Type, Address, and Location columns from a csv and converts each row in to a <device> in an imports config file.
    .EXAMPLE
    Set-ConfigFromCsv 
    .PARAMETER csvFile
    The path to the csv file
    .PARAMETER xmlFile
    The path to the xml file
    #>
    
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true)]
    [Alias("p1")]
    [ValidateNotNullorEmpty()]
    [string]$csvFilePath, 
    [Parameter(Mandatory=$true)]
    [Alias("p2")]
    [ValidateNotNullorEmpty()]
    [string]$xmlFilePath
    )
    Begin{
        Write-Verbose "Writing config file to $($xmlFilePath)"
    }
    Process{
        $csvFile = Import-Csv $csvFilePath
        
        $xmlWriter = New-Object System.Xml.XmlTextWriter($xmlFilePath, $null)
        $xmlWriter.Formatting = 'Indented'
        $xmlWriter.Indentation = 1
        $XmlWriter.IndentChar = "`t"
        $xmlWriter.WriteStartDocument()
        $xmlWriter.WriteStartElement('Imports')
        $xmlWriter.WriteEndElement()
        $xmlWriter.WriteEndDocument()
        $xmlWriter.Flush()
        $xmlWriter.Close()
        
        $xmlDoc = [System.Xml.XmlDocument](Get-Content $xmlFilePath);
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
        }
        $xmlDoc.Save($xmlFilePath)
    }
    End{
    Write-Verbose -Message "Config file written"
    }
}