# frozen_string_literal: true

# Copyright 2016 New Context Services, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "kitchen/terraform/config_attribute"
require "kitchen/terraform/config_attribute_cacher"
require "kitchen/terraform/config_attribute_definer"
require "kitchen/terraform/config_schemas/boolean"

# The +:verify_plugins+ configuration attribute is an optional boolean which toggles verification of Terraform plugins.
#
# @abstract It must be included by a plugin class in order to be used.
# @see https://www.terraform.io/docs/commands/init.html#plugin-installation Terraform: Command: init: Plugin
#   Installation
module ::Kitchen::Terraform::ConfigAttribute::VerifyPlugins
  # A callback to define the configuration attribute which is invoked when this module is included in a plugin class.
  #
  # @param plugin_class [::Kitchen::Configurable] A plugin class.
  # @return [void]
  def self.included(plugin_class)
    ::Kitchen::Terraform::ConfigAttributeDefiner
      .new(
        attribute: self,
        schema: ::Kitchen::Terraform::ConfigSchemas::Boolean
      )
      .define plugin_class: plugin_class
  end

  # @return [::Symbol] the symbol corresponding to the attribute.
  def self.to_sym
    :verify_plugins
  end

  extend ::Kitchen::Terraform::ConfigAttributeCacher

  # @return [true]
  def config_verify_plugins_default_value
    true
  end
end
