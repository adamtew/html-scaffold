#!/bin/bash
# My First Script


echo "
.DS_Store
node_modules
" > .gitignore

echo "
# HTML Scaffold
" > README.md

npm init -f
npm install --save-dev gulp gulp-sass gulp-sass-glob gulp-connect gulp-clean-css gulp-autoprefixer

sed -i.bak s/scripts\"\:\ \{/scripts\"\:\ \{\ \"start\"\:\ \"gulp\",/ package.json

rm package.json.bak

# setup assets file structure
mkdir assets && cd assets
mkdir css js img scss && cd scss
mkdir _lib _layout

echo "
@import '_lib/_variables';
@import '_lib/_helpers';

/* Import loayout files */
@import '/_layout/*';
" > style.scss

touch _lib/_helpers.scss _layout/_layout.scss

echo "
\$configs: (
  content: 105px, // the margins around the content
  content-tablet-lg: 60px,
  content-tablet: 40px,
  content-phone-lg: 15px,
  content-phone: 15px,
  content-small: 36px,
  menu-width: 250px
);

\$colors: (
  background: #FFFFFF, // the main background color
  main: #C0272D, // the dark red on the border
  accent: #989898, // the gray border around the search box
  text-main: #FF0000, // the bright red of all the font headers
  text-accent: #FDFDFD, // the white text with the deep red background in the header
  text-accent-1: #666666, // the really light gray in the copyright - figre__caption
  text-accent-2: #756F6A, // the light gray of all the figure captions - 
  text-accent-3: #CDCCCA, // the light gray in a banner
  text-accent-4: #B2B2B2, // the light gray for the footer links - footer__links-container li
  text-accent-5: #ADB6BE, // really light gray for just now - figure__author:after
  text-accent-6: #CBCBCB, // the really light gray for the copyright - .copyright
  white: white // just in case we want the white to change a little
);

// caption : #666666;
// author  : #ADB6BE;
// just now
// title : #FF0000;
// paragraph : 989898

\$breakpoints: (
  phone: 400px,
  phone-lg: 649px,
  tablet: 767px,
  tablet-lg: 991px,
  desktop: 1300px
);

@function config(\$key) {
  @if map-has-key(\$configs, \$key) {
    @return map-get(\$configs, \$key);
  }
  @warn 'unknown #{\$key} in configs map';
  @return null;
}

@function color(\$key) {
  @if map-has-key(\$colors, \$key) {
    @return map-get(\$colors, \$key);
  }
  @warn 'Unknown #{\$key} in colors map';
  @return null;
}

@function breakpoint(\$key) {
  @if map-has-key(\$breakpoints, \$key) {
    @return map-get(\$breakpoints, \$key);
  }
  @warn 'Unknown #{\$key} in breakpoints map';
  @return null;
}
" > _lib/_variables.scss

cd ../../


echo "var gulp = require('gulp');
var sass = require('gulp-sass');
var sassGlob = require('gulp-sass-glob');
var connect = require('gulp-connect');
var cleanCss = require('gulp-clean-css');
var autoprefixer = require('gulp-autoprefixer');

var theme = 'staples';
var scssPath = './assets/scss/style.scss';
var cssPath = './assets/css';
var watchPath = './assets/scss/**/*.scss'

console.log('watchPath', watchPath)
console.log('theme', theme)
console.log('scssPath', scssPath)
console.log('cssPath', cssPath)

// tasks
gulp.task('style', function() {
  gulp.src(scssPath)
    .pipe(sassGlob())
    .pipe(sass().on('error', sass.logError))
    .pipe(autoprefixer())   
    .pipe(gulp.dest(cssPath));
});

gulp.task('watch', function() {
  gulp.watch(watchPath, ['style']);
});

gulp.task('default', [ /* 'server', */ 'watch']);
" > gulpfile.js

echo "<!DOCTYPE html>
<html lang=\"en\">
<head>
  <meta charset=\"UTF-8\">
  <title>New FIle</title>
  <link rel=\"stylesheet\" href=\"assets/css/style.css\">
</head>
<body>
  Hello World
</body>
</html>
" > index.html

npm start
