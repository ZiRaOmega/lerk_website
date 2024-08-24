#!/bin/bash

# Create necessary directories
mkdir -p nico_website/{img,admin}

# Move existing files into the nico_website directory
mv index.html tuto.html styles.css nico_website/
mv img/* nico_website/img/

# Create a basic netlify.toml file
cat <<EOL > nico_website/netlify.toml
[build]
  publish = "nico_website"  # Directory to publish

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
EOL

# Optional: Set up Netlify CMS
cat <<EOL > nico_website/admin/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Content Manager</title>
</head>
<body>
  <script src="https://unpkg.com/netlify-cms@^2.0.0/dist/netlify-cms.js"></script>
</body>
</html>
EOL

cat <<EOL > nico_website/admin/config.yml
backend:
  name: git-gateway
  branch: main

media_folder: "img"
public_folder: "/img"

collections:
  - name: "pages"
    label: "Pages"
    files:
      - label: "Home"
        name: "home"
        file: "index.html"
        fields:
          - { label: "Title", name: "title", widget: "string" }
          - { label: "Body", name: "body", widget: "markdown" }
      - label: "Tutorial"
        name: "tutorial"
        file: "tuto.html"
        fields:
          - { label: "Title", name: "title", widget: "string" }
          - { label: "Body", name: "body", widget: "markdown" }
EOL

echo "Setup complete. Your project is ready for deployment on Netlify with Visual Editor compatibility."
