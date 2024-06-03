extensions=(downloads/extensions/*)
for extension in "${extensions[@]}"; 
do
  code --verbose --install-extension $extension
done
