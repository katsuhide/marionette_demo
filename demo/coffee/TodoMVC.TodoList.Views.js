// Generated by CoffeeScript 1.7.1
'use strict';
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

TodoMVC.module('TodoList.Views', function(Views, App, Backbone, Marionette, $) {
  return Views.ItemView = (function(_super) {
    __extends(ItemView, _super);

    function ItemView() {
      return ItemView.__super__.constructor.apply(this, arguments);
    }

    ItemView.prototype.tagName = 'li';

    ItemView.prototype.template = '#template-todoItemView';

    ItemView.prototype.ui = {
      edit: '.edit'
    };

    ItemView.prototype.events = {
      'click .destroy': 'destroy',
      'dblclick label': 'onEditClick',
      'keydown .edit': 'onEditKeypress',
      'focusout .edit': 'onEditFocusout',
      'click .toggle': 'toggle'
    };

    ItemView.prototype.modelEvents = {
      'change': 'render'
    };

    ItemView.prototype.onRender = function() {
      this.$el.removeClass('active completed');
      if (this.model.get('completed')) {
        return this.$el.addClass('completed');
      } else {
        return this.$el.addClass('active');
      }
    };

    ItemView.prototype.destroy = function() {
      return this.model.toggle().save();
    };

    ItemView.prototype.onEditClick = function() {
      this.$el.addClass('editing');
      this.ui.edit.focus();
      return this.ui.edit.val(this.ui.edit.val());
    };

    ItemView.prototype.onEditFocusout = function() {
      var todoText;
      todoText = this.ui.edit.val().trim();
      if (todoText) {
        this.model.set('title', todoText(save()));
        return this.$el.removeClass('editing');
      } else {
        return this.destroy;
      }
    };

    ItemView.prototype.onEditKeypress = function(e) {
      var ENTER_KEY, ESC_KEY;
      ENTER_KEY = 13;
      ESC_KEY = 27;
      if (e.which === ENTER_KEY) {
        this.onEditFocusout();
      }
      if (e.which === ESC_KEY) {
        this.ui.edit.val(this.model.get('title'));
        return this.$el.removeClass('editing');
      }
    };

    return ItemView;

  })(Marionette.ItemView);
});
