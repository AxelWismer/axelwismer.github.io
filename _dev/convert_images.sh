convert assets/img/blog/patcat-architecture.png -resize 960x720^ -gravity center -extent 960x720 assets/img/blog/patcat-architecture@1x.png

# Resize a image to the proper proportion
convert assets/img/blog/patcat-architecture.png -resize 960x720 -background transparent -gravity center -extent 960x720 assets/img/blog/patcat-architecture@0,5x.png

# Resize the image to smaller values
convert assets/img/blog/patcat-architecture@0,5x.png -resize 50% -sampling-factor 4:2:0 -strip -quality 85 -interlace JPEG -colorspace RGB assets/img/blog/patcat-architecture@0,25x.png

convert assets/img/blog/patcat-architecture.png -resize 50% -sampling-factor 4:2:0 -strip -quality 85 -interlace JPEG -colorspace RGB assets/img/blog/patcat-architecture@0,5x.png
convert assets/img/blog/patcat-architecture.png -resize 25% -sampling-factor 4:2:0 -strip -quality 85 -interlace JPEG -colorspace RGB assets/img/blog/patcat-architecture@0,25x.png
convert assets/img/blog/patcat-architecture.png -resize 12.5% -sampling-factor 4:2:0 -strip -quality 85 -interlace JPEG -colorspace RGB /assets/img/blog/patcat-architecture@0,125x.png