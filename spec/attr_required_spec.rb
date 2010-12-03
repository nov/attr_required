require 'spec_helper.rb'

class A
  include AttrRequired
  attr_required :attr_a
end

class B < A
  attr_required :attr_b
end

describe AttrRequired, '.attr_required' do
  before do
    @a, @b = A.new, B.new
  end

  it 'should define accessible attributes' do
    @a.should respond_to(:attr_a)
    @a.should respond_to(:attr_a=)
    @b.should respond_to(:attr_b)
    @b.should respond_to(:attr_b=)
  end

  it 'should be inherited' do
    @b.should respond_to(:attr_a)
    @b.should respond_to(:attr_a=)
  end
end

describe AttrRequired, '.attr_required?' do
  it 'should answer whether the attributes is required or not' do
    A.attr_required?(:attr_a).should be_true
    B.attr_required?(:attr_a).should be_true
    B.attr_required?(:attr_b).should be_true
    B.attr_required?(:to_s).should be_false
  end
end

describe AttrRequired, '#attr_required?' do
  before do
    @a, @b = A.new, B.new
  end

  it 'should answer whether the attributes is required or not' do
    @a.attr_required?(:attr_a).should be_true
    @b.attr_required?(:attr_a).should be_true
    @b.attr_required?(:attr_b).should be_true
    @b.attr_required?(:to_s).should be_false
  end
end

describe AttrRequired, '#attr_missing?' do
  before do
    @a, @b = A.new, B.new
  end

  it 'should answer whether any attributes are missing' do
    @a.attr_missing?.should be_true
    @b.attr_missing?.should be_true
    @a.attr_a = 'attr_a'
    @b.attr_a = 'attr_a'
    @a.attr_missing?.should be_false
    @b.attr_missing?.should be_true
    @b.attr_b = 'attr_b'
    @b.attr_missing?.should be_false
  end
end

describe AttrRequired, '#attr_missing!' do
  before do
    @a, @b = A.new, B.new
  end

  it 'should raise AttrMissing error when any attributes are missing' do
    lambda { @a.attr_missing! }.should raise_error(AttrRequired::AttrMissing)
    lambda { @b.attr_missing! }.should raise_error(AttrRequired::AttrMissing)
    @a.attr_a = 'attr_a'
    @b.attr_a = 'attr_a'
    lambda { @a.attr_missing! }.should_not raise_error(AttrRequired::AttrMissing)
    lambda { @b.attr_missing! }.should raise_error(AttrRequired::AttrMissing)
    @b.attr_b = 'attr_b'
    lambda { @b.attr_missing! }.should_not raise_error(AttrRequired::AttrMissing)
  end
end

describe AttrRequired, '.required_attributes' do
  it 'should return all required attributes keys' do
    A.required_attributes.should == [:attr_a]
    B.required_attributes.should == [:attr_a, :attr_b]
  end
end

describe AttrRequired, '#required_attributes' do
  before do
    @a, @b = A.new, B.new
  end

  it 'should return required attributes keys' do
    @a.required_attributes.should == [:attr_a]
    @b.required_attributes.should == [:attr_a, :attr_b]
  end
end

describe AttrRequired, '#attr_missing' do
  before do
    @a, @b = A.new, B.new
  end

  it 'should return missing attributes keys' do
    @a.attr_missing.should == [:attr_a]
    @b.attr_missing.should == [:attr_a, :attr_b]
    @a.attr_a = 'attr_a'
    @b.attr_a = 'attr_a'
    @a.attr_missing.should == []
    @b.attr_missing.should == [:attr_b]
  end
end
