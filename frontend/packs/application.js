// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import * as ActiveStorage from "@rails/activestorage";

import "init";
import "auth/auth";
import "components/page/page";
import "components/navbar/navbar";
import "components/posts/posts";

Rails.start();
ActiveStorage.start();
