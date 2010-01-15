require 'rubygems'
require 'test/unit'
require 'active_record'
require "#{File.dirname(__FILE__)}/../init"
 
class Model
  # ActiveRecord validations without database
  # Thanks to http://www.prestonlee.com/archives/182
  # Updated for Rails 2.3
  def save() end
  def save!() end
  def update_attribute() end
  def new_record?() false end
  def self.self_and_descendents_from_active_record() [self] end
  def self.human_name() end
  def self.human_attribute_name(_) end
  def initialize() @errors = ActiveRecord::Errors.new(self) end
  def self.self_and_descendants_from_active_record
    [self]
  end
  include ActiveRecord::Validations
  
  extend ValidatesCoordinatesFormatOf
 
  attr_accessor :latitude
  validates_latitude_format_of :latitude
  
  attr_accessor :longitude
  validates_longitude_format_of :longitude
  
end
 
class ValidatesCoordinatesFormatOfTest < Test::Unit::TestCase
  
  def setup
    @model = Model.new
  end
  
  def test_should_allow_valid_latitude
    (-90..0).each do |latitude|
      @model.latitude = latitude
      @model.save
      assert !@model.errors.on(:latitude), "#{latitude.inspect} should have been accepted"
    end
    
    (0..90).each do |latitude|
      @model.latitude = latitude
      @model.save
      assert !@model.errors.on(:latitude), "#{latitude.inspect} should have been accepted"
    end
    
  end
  
  def test_should_reject_invalid_latitude
    (-120..-91).each do |latitude|
      @model.latitude = latitude
      @model.save
      assert @model.errors.on(:latitude), "#{latitude.inspect} should have been rejected"
    end
    
    (91..120).each do |latitude|
      @model.latitude = latitude
      @model.save
      assert @model.errors.on(:latitude), "#{latitude.inspect} should have been rejected"
    end
  end
    
  def test_should_allow_valid_longitude
    (-180..0).each do |longitude|
      @model.longitude = longitude
      @model.save
      assert !@model.errors.on(:longitude), "#{longitude.inspect} should have been accepted"
    end
    
    (0..180).each do |longitude| 
      @model.longitude = longitude
      @model.save
      assert !@model.errors.on(:longitude), "#{longitude.inspect} should have been accepted"
    end
    
  end
  
  def test_should_reject_invalid_latitude
    (-200..-181).each do |longitude|
      @model.longitude = longitude
      @model.save
      assert @model.errors.on(:longitude), "#{longitude.inspect} should have been rejected"
    end
    
    (181..201).each do |longitude|
      @model.longitude = longitude
      @model.save
      assert @model.errors.on(:longitude), "#{longitude.inspect} should have been rejected"
    end
  end  
    
end