mkdir -p downloads

echo "download extensions"
extensions=(
  "charliermarsh.ruff-2024.22.0@linux-x64"
  "ms-python.mypy-type-checker@2023.9.11501016"
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

