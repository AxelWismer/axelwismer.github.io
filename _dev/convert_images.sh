# Resize a image to the proper proportion
convert assets/img/blog/patcat-architecture.png -resize 960x720 -background transparent -gravity center -extent 960x720 assets/img/blog/patcat-architecture@0,5x.png

# Resize the image to smaller values (Without removing quality)
convert assets/img/blog/patcat-architecture@0,5x.png -resize 50% -sampling-factor 4:2:0 -interlace JPEG -colorspace RGB assets/img/blog/patcat-architecture@0,25x.png

# Remove background
convert assets/img/logo.png -fuzz 20% -transparent black result.png

# Convert to ico
convert assets/img/2.png -resize 140x140 -gravity center  assets/img/favicon.ico