---
layout: post
title:  "Build and Deploy a SEO Blog with Jekyll"
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
    Build an SEO static site with Jekyll templates and deploy it on GitHub Pages.
---

# Build and Deploy a SEO Blog with Jekyll

[GitHub code]({{page.repository}})

## Why Jekyll?
-------

If you want to build a webpage today, there are many options. From popular JS frameworks like [React](https://react.dev/), [Angular](https://angular.dev/), and [Next.js](https://nextjs.org/) to low/no-code solutions like [Wix](https://www.wix.com/), [Builder.io](https://www.builder.io/), and [Webflow](https://www.wix.com/).

While **JS and CSS frameworks** are free and offer advanced functionalities and great **flexibility**, they require an advanced understanding of frontend design and web technologies. They can also have **performance** and **[SEO](https://developers.google.com/search/docs/fundamentals/seo-starter-guide)** issues.

On the other hand, many **low/no-code** solutions offer great templates, allowing you to start with a fully functional website and then customize it. The trade-offs are the costs and [Vendor Lock-in](https://medium.com/@Infosec-Train/what-is-vendor-lock-in-1259cbe5baa9).

In this context, **[Jekyll](https://jekyllrb.com/)** sits right in the middle. Jekyll is an open-source technology with a large selection of templates and plugins that let you focus on content creation and design rather than building from scratch. It simplifies content creation by using **[Markdown](https://de.wikipedia.org/wiki/Markdown)** (the same as GitHub's README.md) while still allowing the use of HTML, CSS, and JS.

## Finding the Right Theme

By default, a new Jekyll project uses the **[Minima theme](https://github.com/jekyll/minima)**. However, for more personalized themes, you can check out all **[community-maintained themes](https://jekyllrb.com/docs/themes/)**.
For this project, I chose the **[Hydejack](https://hydejack.com/)** free version, as it has many features out of the box like a feed page, about section, math support, and SEO. 

## Fork the GitHub Repo and Set Up GitHub Pages

Go to the selected theme and fork the repo.
![Full-width image](/assets/img/blog/fork-hydejack.png)
For the name, select **{Your GitHub Username}.github.io**, e.g., [axelwismer.github.io](https://github.com/AxelWismer/axelwismer.github.io).

## Deploy the Site on GitHub Pages

For **CI/CD**, we will use GitHub Actions. This allows us to update only the Markdown and .yml files, leaving the generation of all site files to **GitHub Actions**.
![Full-width image](/assets/img/blog/github-pages.png)

GitHub recognizes that the site is made with Jekyll, so it automatically creates the [**workflow file**](https://github.com/AxelWismer/axelwismer.github.io/blob/master/.github/workflows/jekyll.yml).

This file states that GitHub will track push changes on the **master** branch, then install all dependencies (gems), and finally create the static files and put them in the **_site** folder.

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
          bundler-cache: true # Runs 'bundle install' and caches installed gems automatically
          cache-version: 0 # Increment this number if you need to re-download cached gems
      - name: Setup Pages
        id: pages
        uses: actions/configure-pages@v5
      - name: Build with Jekyll
        # Outputs to the './_site' directory by default
        run: bundle exec jekyll build --baseurl "${{ steps.pages.outputs.base_path }}"
...
~~~

Now you have your site deployed on GitHub Pages, and you can update it by pushing new changes to main.

To clone the repository, use [**GitHub Desktop**](https://github.com/apps/desktop) or install [**GitHub CLI**](https://cli.github.com/) and run:

~~~shell
git clone https://github.com/AxelWismer/axelwismer.github.io.git
~~~

## Installing Jekyll and Ruby

To build and serve the site locally to test our changes, we need to install **Ruby**, **Bundler**, and **Jekyll**.

### Installing Ruby

**Ruby** is the language used to render Jekyll's files. Themes are also installed through gems.

[Here](https://www.ruby-lang.org/en/documentation/installation/) you can find the installation guide for each OS.
Since I have Ubuntu 20.04.2, I used Snap to install Ruby.

~~~sh
sudo snap install ruby --classic
~~~

After installation, check the version of Ruby and Gem:

~~~sh
ruby -v     # ruby 3.3.4 (2024-07-09 revision be1089c8ec) [x86_64-linux]
gem -v      # 3.5.11
~~~

### Installing Bundler

**[Bundler](https://bundler.io/)** provides a consistent environment for Ruby projects by tracking and installing the exact gems and versions needed.

~~~sh
gem install bundler
bundle -v   # Bundler version 2.5.15
~~~

### Installing Jekyll

~~~sh
gem install jekyll
~~~

Also, see the full **[installation guide](https://jekyllrb.com/)**.

## Serve the Site in Your Browser

Now that we've installed everything, we can serve the site on localhost (127.0.0.1:4000) by running:

~~~sh
jekyll serve
~~~

To make new changes (except for _config.yml) appear in the browser, run:

~~~sh
jekyll serve --incremental --livereload
~~~
~~~
    LiveReload address: http://127.0.0.1:35729
    Server address: http://127.0.0.1:4000
  Server running... press ctrl-c to stop.
~~~

Enter the link in your browser to see the result.

## Configuring the Site

You can make general configuration changes in the **_config.yml** file.
The parameters you can configure depend on the template and gems you have installed.

Here is an example where I configure the page parameters for **Search Engine Optimization (SEO)** used by the **jekyll-seo-tag** gem.

~~~yml
# Language of your content in 2-letter code, e.g., en, de.
# You may also provide a location, e.g., en-us, de_AT.
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

## Writing Content

Like this article you are reading, every page in Jekyll is a single **.markdown** file which includes the [**Front Matter**](https://jekyllrb.com/docs/front-matter/) and the content.


~~~markdown
---
layout: post
title:  "Build and Deploy a SEO Blog with Jekyll"
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
    Build an SEO static site with Jekyll templates and deploy it on GitHub Pages.
---
# Build and Deploy a SEO Blog with Jekyll
Content
...
~~~
Here is the result from the feed page (part of Hidejack template)

![Full-width image](/assets/img/blog/jekyll-blog-view.jpg)

The pages are located in the blog/_posts folder in my case.

## Handling Images

To insert an image, you can reference a file in your directories or provide an external link:

~~~markdown
![alt](/assets/img/blog/github-pages.png) # Local image
![alt](https://jekyllrb.com/img/logo-2x.png) # External image
~~~

It's better to serve local files, as you can make changes to them and ensure they are always available.

### Editing Images with ImageMagick

While creating this page, I found that I needed to modify many images to serve them in the right sizes and proportions.
I also wanted to perform operations like extending the background of an image or changing its format.

For that, I compiled a script that uses [**ImageMagick**](https://imagemagick.org/index.php) to perform all necessary operations on the files.
This also has the advantage that once I define the changes an image should have, I can replace the image with a new version and run the script again to apply the changes.

Here is an example:

~~~shell
# Resize an image to the right proportion
convert assets/img/blog/patcat-architecture.png -resize 960x720 -background transparent -gravity center -extent 960x720 assets/img/blog/patcat-architecture@0,5x.png

# Remove background
convert assets/img/logo.png -fuzz 20% -transparent black result.png

# Create icon
# Convert to ico
convert assets/icons/icon.png -resize 140x140 -gravity center assets/icons/favicon.ico

# Convert to all the sizes
convert assets/icons/icon.png -resize 512x512 -background transparent -gravity center assets/icons/icon-512x512.png
convert assets/icons/icon.png -resize 384x384 -background transparent -gravity center assets/icons/icon-384x384.png
convert assets/icons/icon.png -resize 192x192 -background transparent -gravity center assets/icons/icon-192x192.png
...
~~~

### Embedding Videos

To embed a video, I created an HTML file in the [**_includes**](https://jekyllrb.com/docs/includes/) folder, which allows me to write reusable snippets.

~~~html
<!-- source: https://github.com/nathancy/jekyll-embed-video -->
<video controls>
  <source src="{{ include.id }}">
  Your browser does not support the video tag.
</video>
~~~

Then I include it in the post with:

~~~jinja
{% raw %}{% include video.html id="https://user-images.githubusercontent.com/49920097/206914537-8491be30-90f3-4940-bc67-e5427cbdaadf.mp4" %}{% endraw %}
~~~

For example, this is an embedded video from my project [**ECDSA Node**](/blog/_posts/2022-12-11-ecdsa-node.markdown).
{% include video.html id="https://user-images.githubusercontent.com/49920097/206914537-8491be30-90f3-4940-bc67-e5427cbdaadf.mp4" %}

---
That's it! Now you can build a static blog with a modern look and deploy it for free on GitHub.
If you want to see more examples, check out the rest of my [**Blog**](/blog), or the code for this project on my [**Repo**]({{page.repository}}).

