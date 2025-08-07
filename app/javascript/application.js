import { Application } from "@hotwired/stimulus";
import { definitionsFromContext } from "@hotwired/stimulus-loading";
import * as ActiveStorage from "@rails/activestorage";
import * as Turbo from "@hotwired/turbo-rails";
import "controllers";

window.Stimulus = Application.start();
const context = require.context("./controllers", true, /\.js$/);
Stimulus.load(definitionsFromContext(context));
