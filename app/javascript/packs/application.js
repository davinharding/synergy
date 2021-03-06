/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import ReactOnRails from 'react-on-rails';
import Profile from '../bundles/Carousel/Profile'
import HelloWorld from '../bundles/HelloWorld/components/HelloWorld';
import Messages from '../bundles/Messages/components/Messages';
import Notifications from '../bundles/Notifications/components/Notifications';
import 'babel-polyfill'

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  HelloWorld,
  Profile,
  Messages,
  Notifications
});