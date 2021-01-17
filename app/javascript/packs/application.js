// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import '../stylesheets/application'
import './bootstrap_custom.js'
require('datatables.net-bs4')

import $ from 'jquery';
global.$ = jQuery;

Rails.start()
Turbolinks.start()
ActiveStorage.start()


jQuery(document).ready(function() {
  $('#company-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    "dom": '<"top"fi>rt<"bottom"lp>',
    "ajax": {
      "url": $('#company-datatable').data('source')
    },
    "pagingType": "full_numbers",
    "columns": [
      {"data": "id"},
      {"data": "name"},
      {"data": "address"},
      {"data": "email"},
      {"data": "phone_number"},
      {"data": "capacity"},
      {"data": "link"}
    ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  });
});
