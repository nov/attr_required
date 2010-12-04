require 'spec_helper.rb'

describe AttrOptional, '.attr_optional' do
  before do
    @a, @b = A.new, B.new
  end

  it 'should define accessible attributes' do
    @a.should respond_to(:attr_optional_a)
    @a.should respond_to(:attr_optional_a=)
    @b.should respond_to(:attr_optional_b)
    @b.should respond_to(:attr_optional_b=)
  end

  it 'should be inherited' do
    @b.should respond_to(:attr_optional_a)
    @b.should respond_to(:attr_optional_a=)
  end
end

describe AttrOptional, '.attr_optional?' do
  it 'should answer whether the attributes is optional or not' do
    A.attr_optional?(:attr_optional_a).should be_true
    B.attr_optional?(:attr_optional_a).should be_true
    B.attr_optional?(:attr_optional_b).should be_true
    B.attr_optional?(:to_s).should be_false
  end
end

describe AttrOptional, '#attr_optional?' do
  before do
    @a, @b = A.new, B.new
  end

  it 'should answer whether the attributes is optional or not' do
    @a.attr_optional?(:attr_optional_a).should be_true
    @b.attr_optional?(:attr_optional_a).should be_true
    @b.attr_optional?(:attr_optional_b).should be_true
    @b.attr_optional?(:to_s).should be_false
  end
end

describe AttrOptional, '.optional_attributes' do
  it 'should return all optional attributes keys' do
    A.optional_attributes.should == [:attr_optional_a]
    B.optional_attributes.should == [:attr_optional_a, :attr_optional_b]
  end
end

describe AttrOptional, '#optional_attributes' do
  before do
    @a, @b = A.new, B.new
  end

  it 'should return optional attributes keys' do
    @a.optional_attributes.should == [:attr_optional_a]
    @b.optional_attributes.should == [:attr_optional_a, :attr_optional_b]
  end
end
