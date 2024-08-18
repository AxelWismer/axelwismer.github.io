---
layout: post
title:  "Build and deploy a SEO blog with Jekyll"
tags: frontend jekyll
sitemap: false
repository: https://github.com/AxelWismer/axelwismer.github.io
image: 
  path: /assets/img/thumbnail-1920x1080.jpg
  srcset:
    1920w:  /assets/img/blog/jekyll-blog-1920x1080.jpg
    960w:   /assets/img/blog/jekyll-blog-960x540.jpg
    480w:   /assets/img/blog/jekyll-blog-480x270.jpg
description: > 
    Build a SEO static site with Jekyll templates and deploy it in Github pages .

---

# Build and deploy a SEO blog with Jekyll


[Github code]({{page.repository}})


## Why Jekyll?
-------

If you want to build a web page today, there is a range of options. From known JS frameworks like [React](https://react.dev/), [Angular](https://angular.dev/) and [Next.js](https://nextjs.org/) to Low/No code solutions like [Wix](https://www.wix.com/), [Builder.io](https://www.builder.io/) and [Webflow](https://www.wix.com/).

While the **JS and CSS frameworks** are free and provide advance functionalities and great **flexibility**, they require an advance understanding of frontend design and web technologies. They can also have **performance** and **[SEO]**(https://developers.google.com/search/docs/fundamentals/seo-starter-guide) issues.  

On the other hand, many **Low/No Code** solutions have great templates that allow you to start with a fully functional website and then customize it to your needs. The trade-offs are the costs and [Vendor Lock-in](https://medium.com/@Infosec-Train/what-is-vendor-lock-in-1259cbe5baa9).

In that context **[Jekyll](https://jekyllrb.com/)** sits right in the middle. Jekyll is an open source technology with a large option of templates and plugins that lets you go directly to content creation and page design instead of having to build a page from scratch. It's simplifies the creation of content by using **[markdown](https://de.wikipedia.org/wiki/Markdown)** (same as GitHub's README.md) while still allowing the use of HTML, CSS and JS.


## Finding the right theme
By default a new Jekyll project will use the **[Minima theme](https://github.com/jekyll/minima)**. However, for more personalized themes you can check all **[community-maintained themes](https://jekyllrb.com/docs/themes/)**.
For this project I chose **[Hydejack](https://hydejack.com/)** free version, since it has a lot of features out of the box like a feed page, about section, math support and SEO. 

## Fork the GitHub repo and setting up GitHub Pages
Go to the selected theme and fork the repo.
![Full-width image](/assets/img/blog/fork-hydejack.png)
For the name select **{Your GitHub Username}.github.io** e.g: [axelwismer.github.io](https://github.com/AxelWismer/axelwismer.github.io)

## Deploy the site in GitHub pages
For the **CI/CD** we will use GitHub Actions, this will allow us to update only the markdown and .yml files and leave the generation of all the site files to **GitHub's actions**.
![Full-width image](/assets/img/blog/github-pages.png)

GitHub recognizes that the site is made with Jekyll, so it creates the [workflow file](https://github.com/AxelWismer/axelwismer.github.io/blob/master/.github/workflows/jekyll.yml) automatically.

This files states that GitHub will track push changes on the **master** branch, then it will install all the dependencies (gems) and finally it will create the statics files and put them in the **_site** folder.
~~~yml
...
on:
  # Runs on pushes targeting the default branch
  push:
    branches: ["master"]
...
jobs:
  # Build job
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      - name: Setup Ruby
        uses: ruby/setup-ruby@8575951200e472d5f2d95c625da0c7bec8217c42 # v1.161.0
        with:
          ruby-version: '3.1' # Not needed with a .ruby-version file
          bundler-cache: true # runs 'bundle install' and caches installed gems automatically
          cache-version: 0 # Increment this number if you need to re-download cached gems
      - name: Setup Pages
        id: pages
        uses: actions/configure-pages@v5
      - name: Build with Jekyll
        # Outputs to the './_site' directory by default
        run: bundle exec jekyll build --baseurl "${{ steps.pages.outputs.base_path }}"
...
~~~

Now you have your site deployed in GitHub Pages and you can update it by pushing new changes to main.

To clone the repository use [GitHub Desktop](https://github.com/apps/desktop) or install [GitHub CLI](https://cli.github.com/) and run:

~~~shell
git clone https://github.com/AxelWismer/axelwismer.github.io.git
~~~


## Installing Jekyll and Ruby
In order to be able to build and serve the site locally to test our changes we need to install **Ruby**, **Bundler** and **Jekyll** 
### Installing Ruby

**Ruby** is the language used to render Jekyll's files, also the themes will be installed trough gem.

[Here](https://www.ruby-lang.org/en/documentation/installation/) you can find the installation guide to each OS.
Since I have Ubuntu 20.04.2, I used snap to install Ruby.
~~~sh
    sudo snap install ruby --classic
~~~
After the installation check the version of ruby and gem
~~~sh
    ruby -v     # ruby 3.3.4 (2024-07-09 revision be1089c8ec) [x86_64-linux]
    gem -v      # 3.5.11
~~~
### Installing Bundler

**[Bundler](https://bundler.io/)** provides a consistent environment for Ruby projects by tracking and installing the exact gems and versions that are needed.
~~~sh
    gem install bundler
    bundle -v   # Bundler version 2.5.15
~~~
### Installing Jekyll
~~~sh
    gem install jekyll
~~~
Also, see the full **[installation guide](https://jekyllrb.com/)**


## Serve the site in your browser
Now we installed everything, we can serve the site in the localhost (127.0.0.1:4000) by running
~~~sh
  jekyll serve
~~~
To make any new changes (except for _config.yml) appear in the browser run
~~~sh
  jekyll serve --incremental --livereload
~~~
~~~
  ...
    LiveReload address: http://127.0.0.1:35729
    Server address: http://127.0.0.1:4000
  Server running... press ctrl-c to stop.
~~~
Enter the link in your browser and see the result

## Configuring the site
You can make general configuration changes in the **_config.yml** file.
The parameters you can configure depend on the template and gems you have installed.

Here is an example where I configure the page parameters for **Search Engine Optimization (SEO)**
that are used by **jekyll-seo-tag** gem.
~~~yml
# Language of your content in 2-letter code, e.g.: en, de.
# You may also provide a location, e.g.: en-us, de_AT.
lang:                  en

# The title of your blog. Used in the sidebar and the browser tab.
title:                 Axel Wismer

# A short description (~150 chars) of the page used for the meta description tag.
# Can use markdown, but no more than one paragraph (enforced by `>`)
description:           >
  This portfolio showcases my projects in frontend, backend, cloud, cryptography, and smart contracts. 

# A shorter description for the sidebar.
tagline:               Systems Engineer

# A list of keywords for your blog
keywords:              [Axel, Wismer, Systems Engineer, frontend, backend, cloud, GCP, AWS, blockchain, python, js, javascript, smart contract, blog, articles]

# A (square) logo for your site.
# If provided, it will be shown at the top of the sidebar.
# It also used by the `jekyll-seo-tag` plugin.
logo:                  /assets/img/logo.png
~~~

## Writing content
Finally! Let's write some content.
Like this article you are seeing, every page in Jekyll is a single **.markadown** file which includes the [**Front Matter**](https://jekyllrb.com/docs/front-matter/) and the content.

~~~markdown
---
layout: post
title: Blogging Like a Hacker
---
## Title
Some content
...
~~~
The pages are located at in the blog/_posts folder in my case

## Handling images
To insert an image you can reference to a file in your directories or to provide an external link
~~~markdown
![alt](/assets/img/blog/github-pages.png) # Local image
![alt](https://jekyllrb.com/img/logo-2x.png) # External image
~~~
Is better to serve local files since it you can make changes to them and ensure that they always will be available

### Editing images with ImageMagick
While creating this page I found that I needed that modify a lot of images to be able to serve them in the right sizes and proportions.
I also wanted to do operation such a extending the background of an image or changing it's format.

For that I compiled a script that uses [ImageMagick](https://imagemagick.org/index.php) to perform all the necesarry operations of the files.
This also has the advantage that once I defined all the changes an extension an image should have I can replace the image for a new version and run the script again to apply the changes

Here is an example
~~~shell
# Resize a image to the proper proportion
convert assets/img/blog/patcat-architecture.png -resize 960x720 -background transparent -gravity center -extent 960x720 assets/img/blog/patcat-architecture@0,5x.png

# Remove background
convert assets/img/logo.png -fuzz 20% -transparent black result.png

# Create icon
# Convert to ico
convert assets/icons/icon.png -resize 140x140 -gravity center assets/icons/favicon.ico

## Convert to all the sizes
convert assets/icons/icon.png -resize 512x512 -background transparent -gravity center assets/icons/icon-512x512.png
convert assets/icons/icon.png -resize 384x384 -background transparent -gravity center assets/icons/icon-384x384.png
convert assets/icons/icon.png -resize 192x192 -background transparent -gravity center assets/icons/icon-192x192.png
...
~~~

### Embeding videos
To embed the video I created an html file in the _includes folder which allows me to write reusable snippets.
~~~html
<!-- source: https://github.com/nathancy/jekyll-embed-video -->
<video controls>
  <source src="{{ include.id }}">
  Your browser does not support the video tag.
</video>
~~~
Then I include it the post with post 
~~~jinja
{% raw %}{% include video.html id="https://user-images.githubusercontent.com/49920097/206914537-8491be30-90f3-4940-bc67-e5427cbdaadf.mp4" %}{% endraw %}
~~~

For example this is an embeded video from my project [**ECDSA Node**](/blog/_posts/2022-12-11-ecdsa-node.markdown).
{% include video.html id="https://user-images.githubusercontent.com/49920097/206914537-8491be30-90f3-4940-bc67-e5427cbdaadf.mp4" %}

That's it, now you can build a static blog with modern looks and deploy it for free in GitHub.
If you want to see more example check out the rest of my [**blog**](/blog), or the code for this project on my [**repo**]({{page.repository}}).
