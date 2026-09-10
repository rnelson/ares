if (Test-Path -Path ./build) { Remove-Item -Recurse -Force build }
if (-not (Test-Path -Path ./build)) {
    New-Item -Type directory -Name build | Out-Null
    New-Item -Type directory -Name "build/K0ROS ARES" | Out-Null
    New-Item -Type directory -Name "build/K0ROS ARES/ICS_NIMS" | Out-Null
}
Push-Location

### ICS (IS-100) and NIMS (IS-700) training
Set-Location -Path ./training/ICS_NIMS

# Build the slide deck
bs e -b
Copy-Item -Path ../../assets/img/repo_qr_sm.png -Destination dist
if (Test-Path -Path ./dist) { Move-Item -Path dist/* -Destination "../../build/K0ROS ARES/ICS_NIMS" }
if (Test-Path -Path ./dist) { Remove-Item -Path dist -Force -Recurse }

# Convert the notes into PDFs
Push-Location
Set-Location -Path ./notes
md-to-pdf "./IS-100 Introduction to the Incident Command System.md"
if (Test-Path -Path "./IS-100 Introduction to the Incident Command System.pdf") {
    Move-Item -Path "./IS-100 Introduction to the Incident Command System.pdf" -Destination "../../../build/K0ROS ARES/ICS_NIMS"
}
md-to-pdf "./IS-700 Introduction to the National Incident Management System.md"
if (Test-Path -Path "./IS-700 Introduction to the National Incident Management System.pdf") {
    Move-Item -Path "./IS-700 Introduction to the National Incident Management System.pdf" -Destination "../../../build/K0ROS ARES/ICS_NIMS"
}
#Move-Item -Path *.pdf -Destination "../../../build/K0ROS ARES/ICS_NIMS"
Pop-Location

# Return to the root
Pop-Location