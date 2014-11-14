require 'puppet/parser/ast/top_level_construct'

class Puppet::Parser::AST::Node < Puppet::Parser::AST::TopLevelConstruct
  attr_accessor :names, :context

  def initialize(names, context = {})
    raise ArgumentError, "names should be an array" unless names.is_a? Array
    if context[:parent]
      raise Puppet::DevError, "Node inheritance is removed in Puppet 4.0.0. See http://links.puppetlabs.com/puppet-node-inheritance-deprecation"
    end

    @names = names
    @context = context
  end

  def instantiate(modname)
    @names.map do |name|
      Puppet::Resource::Type.new(:node, name, @context.merge(:module_name => modname))
    end
  end
end
