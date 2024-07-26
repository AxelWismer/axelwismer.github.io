# Resize a image to the proper proportion
convert assets/img/blog/patcat-architecture.png -resize 960x720 -background transparent -gravity center -extent 960x720 assets/img/blog/patcat-architecture@0,5x.png

# Resize the image to smaller values (Without removing quality)
convert assets/img/blog/patcat-architecture@0,5x.png -resize 50% -sampling-factor 4:2:0 -interlace JPEG -colorspace RGB assets/img/blog/patcat-architecture@0,25x.png

# Remove background
convert assets/img/logo.png -fuzz 20% -transparent black result.png


# Create icon
# Convert to ico
convert assets/icons/icon.png -resize 140x140 -gravity center assets/icons/favicon.ico


## Convert to all the sizes
convert assets/icons/icon.png -resize 512x512 -background transparent -gravity center assets/icons/icon-512x512.png
convert assets/icons/icon.png -resize 384x384 -background transparent -gravity center assets/icons/icon-384x384.png
convert assets/icons/icon.png -resize 192x192 -background transparent -gravity center assets/icons/icon-192x192.png
convert assets/icons/icon.png -resize 152x152 -background transparent -gravity center assets/icons/icon-152x152.png
convert assets/icons/icon.png -resize 144x144 -background transparent -gravity center assets/icons/icon-144x144.png
convert assets/icons/icon.png -resize 96x96 -background transparent -gravity center assets/icons/icon-96x96.png
convert assets/icons/icon.png -resize 72x72 -background transparent -gravity center assets/icons/icon-72x72.png

## Convert thumbnail
## Resize to the correct format by cropping 
convert assets/img/thumbnail.png -resize 1920x1080^ -gravity center -crop 1920x1080+0+0 +repage assets/img/thumbnail-1920x1080.jpg

## Resize proportionally
convert assets/img/thumbnail-1920x1080.jpg -resize 960x540 -background transparent -gravity center assets/img/thumbnail-960x540.jpg
convert assets/img/thumbnail-1920x1080.jpg -resize 480x270 -background transparent -gravity center assets/img/thumbnail-480x270.jpg

## Extend background rand resize
convert assets/img/blog/ecdsa-node.png -resize 1920x1080 -background "rgb(227,232,241)" -gravity center -extent 1920x1080 assets/img/blog/ecdsa-node@1x.jpg
convert assets/img/blog/ecdsa-node@1x.jpg -resize 960x540 -gravity center assets/img/blog/ecdsa-node@0,5x.jpg
convert assets/img/blog/ecdsa-node@1x.jpg -resize 480x270 -gravity center assets/img/blog/ecdsa-node0,25x.jpg

## Blockexplorer: Extend background rand resize
convert assets/img/blog/blockexplorer.png -resize 1920x1080 -background "rgb(247, 245, 247)" -gravity center -extent 1920x1080 assets/img/blog/blockexplorer@1x.jpg
convert assets/img/blog/blockexplorer@1x.jpg -resize 960x540 -gravity center assets/img/blog/blockexplorer@0,5x.jpg
convert assets/img/blog/blockexplorer@1x.jpg -resize 480x270 -gravity center assets/img/blog/blockexplorer0,25x.jpg
