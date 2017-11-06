cd /home/yujinhai/github/blog
git pull
bundle exec jekyll serve
sed -i "s/http:/https:/g" `find ./_site/ -name *.html`
