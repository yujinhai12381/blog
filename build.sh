cd /home/yujinhai/github/blog
bundle exec jekyll serve
sed -i "s/http:/https:/g" `find ./_site/ -name *.html`
