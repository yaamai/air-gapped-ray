mkdir -p downloads

echo "download extensions"
extensions=(
  "ms-python.python@2023.22.1"  
  "ms-python.vscode-pylance@2023.12.1"  
  "ms-vscode-remote.remote-containers@0.327.0"  
  "ms-vscode-remote.remote-ssh@0.107.1"  
  "ms-vscode-remote.remote-ssh-edit@0.86.0"  
  "ms-vscode-remote.vscode-remote-extensionpack@0.25.0"  
  "ms-vscode.live-server@0.4.13"  
  "ms-vscode.remote-explorer@0.4.1"  
  "ms-vscode.remote-server@1.5.0"
  "hediet.vscode-drawio@1.6.6"
  "redhat.vscode-yaml@1.15.0"
)

mkdir -p downloads/extensions
for extension in "${extensions[@]}"
do
  extension_string="$(echo ${extension} | cut -d "@" -f 1)"
  version="$(echo ${extension} | cut -d "@" -f 2)"
  publisher="$(echo $extension_string | cut -d "." -f 1)"
  extension="$(echo $extension_string | cut -d "." -f 2)"
  (cd downloads/extensions && \
  curl -O https://${publisher}.gallery.vsassets.io/_apis/public/gallery/publisher/${publisher}/extension/${extension}/${version}/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage && \
  mv Microsoft.VisualStudio.Services.VSIXPackage ${publisher}.${extension}.vsix )
done

