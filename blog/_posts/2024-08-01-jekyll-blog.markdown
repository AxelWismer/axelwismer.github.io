---
layout: post
title: "Build an SEO Blog with Jekyll"
tags:
  - Jekyll
  - SEO
  - GitHub Pages
  - Frontend
  - Ruby
  - Markdown
sitemap: false
repository: https://github.com/AxelWismer/axelwismer.github.io
image: 
  path: /assets/img/thumbnail-1920x1080.jpg
  srcset:
    1920w:  /assets/img/blog/jekyll-blog-1920x1080.jpg
    960w:   /assets/img/blog/jekyll-blog-960x540.jpg
    480w:   /assets/img/blog/jekyll-blog-480x270.jpg
description: > 
    Create an SEO-friendly static blog using Jekyll and GitHub Pages.
---

# Build an SEO Blog with Jekyll

[GitHub code]({{page.repository}})

## Why Jekyll?

When building a website today, there are numerous options available. Popular JavaScript frameworks like [React](https://react.dev/), [Angular](https://angular.dev/), and [Next.js](https://nextjs.org/) offer advanced functionality and flexibility but require a strong understanding of frontend design and web technologies. They can also pose challenges for performance and [SEO](https://developers.google.com/search/docs/fundamentals/seo-starter-guide).

On the other hand, low/no-code solutions such as [Wix](https://www.wix.com/), [Builder.io](https://www.builder.io/), and [Webflow](https://www.wix.com/) provide excellent templates for starting a fully functional website with ease, though they often come with costs and [vendor lock-in](https://medium.com/@Infosec-Train/what-is-vendor-lock-in-1259cbe5baa9).

**Jekyll** offers a middle ground. As an open-source tool, Jekyll provides a range of templates and plugins that allow you to focus on content creation and design rather than building everything from scratch. It simplifies content creation using **[Markdown](https://de.wikipedia.org/wiki/Markdown)**, similar to GitHub's README.md files, while still supporting HTML, CSS, and JavaScript.

## Finding the Right Theme

By default, a new Jekyll project uses the **[Minima theme](https://github.com/jekyll/minima)**. For more personalized themes, explore the **[community-maintained themes](https://jekyllrb.com/docs/themes/)**. 

For this project, I selected the **[Hydejack](https://hydejack.com/)** free version. It includes many features out of the box, such as a feed page, an about section, math support, and SEO features.

## Fork the GitHub Repo and Set Up GitHub Pages

Visit the theme’s page and fork the repository. Name it **{Your GitHub Username}.github.io**, e.g., [axelwismer.github.io](https://github.com/AxelWismer/axelwismer.github.io).

## Deploy the Site on GitHub Pages

To automate deployment, we use GitHub Actions for continuous integration and delivery. This setup allows us to manage only the Markdown and `.yml` files, with GitHub Actions handling site generation.

GitHub recognizes that the site uses Jekyll and automatically creates the [**workflow file**](https://github.com/AxelWismer/axelwismer.github.io/blob/master/.github/workflows/jekyll.yml). This file configures GitHub to monitor changes to the **master** branch, install dependencies (gems), and generate static files into the **_site** folder.

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

Your site will now be deployed on GitHub Pages. To update it, simply push new changes to the main branch.

To clone the repository, use [**GitHub Desktop**](https://github.com/apps/desktop) or install [**GitHub CLI**](https://cli.github.com/) and run:

~~~shell
git clone https://github.com/AxelWismer/axelwismer.github.io.git
~~~

## Installing Jekyll and Ruby

To build and serve the site locally, you'll need to install **Ruby**, **Bundler**, and **Jekyll**.

### Installing Ruby

**Ruby** is the language used to render Jekyll’s files and install themes through gems.

Find the installation guide for each operating system [here](https://www.ruby-lang.org/en/documentation/installation/). On Ubuntu 20.04.2, I used Snap to install Ruby:

~~~sh
sudo snap install ruby --classic
~~~

After installation, verify the Ruby and Gem versions:

~~~sh
ruby -v     # ruby 3.3.4 (2024-07-09 revision be1089c8ec) [x86_64-linux]
gem -v      # 3.5.11
~~~

### Installing Bundler

**[Bundler](https://bundler.io/)** ensures a consistent environment for Ruby projects by managing gem dependencies.

~~~sh
gem install bundler
bundle -v   # Bundler version 2.5.15
~~~

### Installing Jekyll

~~~sh
gem install jekyll
~~~

For the complete installation guide, visit [Jekyll’s official site](https://jekyllrb.com/).

## Serve the Site in Your Browser

Once everything is installed, you can serve the site locally at `localhost:4000` by running:

~~~sh
jekyll serve
~~~

For incremental updates (excluding changes to _config.yml) and live reload:

~~~sh
jekyll serve --incremental --livereload
~~~
~~~
    LiveReload address: http://127.0.0.1:35729
    Server address: http://127.0.0.1:4000
  Server running... press ctrl-c to stop.
~~~

Open the provided link in your browser to view the site.

## Configuring the Site

You can make general configuration changes in the **_config.yml** file. The parameters available depend on the template and gems used.

Here’s an example configuration for **Search Engine Optimization (SEO)** with the **jekyll-seo-tag** gem:

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

In Jekyll, each page is a single **.markdown** file that includes the [**Front Matter**](https://jekyllrb.com/docs/front-matter/) and content.

~~~markdown
---
layout: post
title:  "Build an SEO Blog with Jekyll"
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
# Build an SEO Blog with Jekyll
Content
...
~~~
Here is a preview from the feed page (part of the Hydejack template):

![Page preview](/assets/img/blog/jekyll-blog-view.jpg)

The pages are located in the `blog/_posts` folder in my case.

## Handling Images

To insert an image, reference a file in your directories or provide an external link:

~~~markdown
![Local image](/assets/img/blog/github-pages.png)
![External image](https://jekyllrb.com/img/logo-2x.png)
~~~

Serving local files is preferable as it ensures they are always available and allows for easy modifications.

### Editing Images with ImageMagick

I used [**ImageMagick**](https://imagemagick.org/index.php) to modify images, such as resizing, changing formats, or extending backgrounds. I created a script to automate these tasks, so you can replace images and reapply the script as needed.

Here’s an example:

~~~shell
# Resize an image to the correct proportion
convert assets/img/blog/patcat-architecture.png -resize 960x720 -background transparent -gravity center -extent 960x720 assets/img/blog/patcat-architecture@0,5x.png

# Remove background
convert assets/img/logo.png -fuzz 20% -transparent black result.png

# Create icon in .ico format
convert assets/icons/icon.png -resize 140x140 -gravity center assets/icons/favicon.ico

# Convert to multiple sizes
convert assets/icons/icon.png -resize 512x512 -background transparent -gravity center assets/icons/icon-512x512.png
convert assets/icons/icon.png -resize 384x384 -background transparent -gravity center assets/icons/icon-384x384.png
convert assets/icons/icon.png -resize 192x192 -background transparent -gravity center assets/icons/icon-192x192.png
...
~~~

### Embedding Videos

To embed a video, create an HTML file in the [**_includes**](https://jekyllrb.com/docs/includes/) folder with reusable snippets:

~~~html
<!-- source: https://github.com/nathancy/jekyll-embed-video -->
<video controls>
  <source src="{{ include.id }}">
  Your browser does not support the video tag.
</video>
~~~

Include it in your post with:

~~~jinja
{% raw %}{% include video.html id="https://user-images.githubusercontent.com/49920097/206914537-8491be30-90f3-4940-bc67-e5427cbdaadf.mp4" %}{% endraw %}
~~~

For instance, here is an embedded video from my project [**ECDSA Node**](/blog/_posts/2022-12-11-ecdsa-node.markdown):
{% include video.html id="https://user-images.githubusercontent.com/49920097/206914537-8491be30-90f3-4940-bc67-e5427cbdaadf.mp4" %}

---

That's it! You now have a static blog with a modern look deployed for free on GitHub Pages. For more examples, check out the rest of my [**Blog**](/blog), or view the code for this project on my [**Repo**]({{page.repository}}).
