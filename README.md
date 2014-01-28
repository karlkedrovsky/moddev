# Vagrant VM For Basic Module Development Presentation

This contains the vagrant file for setting up a VM with an
installation of Drupal used for my presentation at the 1/28/2014 KC
Drupal Users Group meeting. To use it just do the following.

1. Install [VirtualBox](https://www.virtualbox.org/)
1. Install [Vagrant](http://www.vagrantup.com/)
1. git clone https://github.com/karlkedrovsky/moddev.git
1. cd moddev
1. vagrant up

After that you should be able to go to http://10.1.0.31 and log in
using a user name of "admin" and the password "admin".

You might want to take a look at the Vagrantfile to make sure the IP
(and anything else) don't conflict with your maching. It would also be
handy to update your hosts file to point the host "moddev" to the IP
address in Vagranfile.

The VM contains an NFS export of the docroot of the site so that you
can mount it from the host and use your favorite editor to edit
files. I use a start.sh and stop.sh script to start/stop my VMs and
take care of mounting and unmounting the shares. Just take a look at
them and you'll see how it's done.

## Code Samples

### hook_node_view

    /**
     * Implements hook_node_view().
     */
    function kcdug_node_view($node, $view_mode, $langcode) {
      $node->content['my_additional_field'] = array(
        '#markup' => '<strong>This is an additional field</strong>',
        '#weight' => 10,
      );
    }

### hook_node_load

    /**
     * Implements hook_node_load().
     */
    function kcdug_node_load($nodes, $types) {
      $first_nid = array_shift(array_keys($nodes));
      $nodes[$first_nid]->title = 'Foo ' . $nodes[$first_nid]->title;
    }

### hook_form_FORM_ID_alter

See https://api.drupal.org/api/drupal/developer%21topics%21forms_api_reference.html/7

    /**
     * Implements hook_form_FORM_ID_alter().
     */
    function kcdug_form_page_node_form_alter(&$form, &$form_state, $form_id) {
      $form['author']['#access'] = false;
    }

### hook_menu

    /*
     * Implements hook_menu().
     */
    function kcdug_menu() {
      $items = array();
      $items['foo'] = array(
        'title' => 'Foo',
        'description' => 'Foo',
        'page callback' => 'kcdug_foo',
        'access arguments' => array('access content'),
        'type' => MENU_NORMAL_ITEM,
      );
      return $items;
    }

    function kcdug_foo() {
      return '<p>This came from a custom module</p>';
    }

### Adding a configuration page

See https://api.drupal.org/api/drupal/modules%21system%21system.module/function/system_settings_form/7

    /*
     * Implements hook_menu().
     */
    function kcdug_menu() {
      $items = array();
      $items['admin/config/kcdug'] = array(
        'title' => 'Title Prefix',
        'description' => 'Title prefix',
        'page callback' => 'drupal_get_form',
        'page arguments' => array('title_prefix_form'),
        'access arguments' => array('administer content'),
        'type' => MENU_NORMAL_ITEM,
      );
      return $items;
    }

    /*
     * Form for title prefix
     */
    function title_prefix_form($form, &$form_state) {
      $form['kcdug'] = array (
        'kcdug_title_prefix' => array (
          '#type' => 'textfield',
          '#title' => t('Title Prefix'),
          '#description' => t('Enter the prefix for all the titles.'),
          '#default_value' => variable_get('kcdug_title_prefix'),
          '#size' => 40,
          '#maxlength' => 255,
          '#required' => 1,
        ),
      );
      return system_settings_form($form);
    }

## Resources

http://api.drupal.org

https://drupal.org/developing/modules

http://drupalize.me/series/module-development-drupal-7
