# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Brand, type: :model do
  describe '.new' do
    let(:brand) { build(:brand) }

    it 'belongs to Brand class' do
      expect(brand).to be_a Brand
    end

    context 'with valid attributes' do
      it 'is valid' do
        expect(brand).to be_valid
      end
    end

    context 'without a name' do
      it 'is invalid' do
        brand.name = nil
        expect(brand).to_not be_valid
      end
    end
  end

  describe '.create' do
    let!(:brand) { create(:brand, name: 'A') }

    context 'with an existed brand name' do
      it 'is invalid' do
        new_brand = build(:brand, name: 'A')
        expect(new_brand).to_not be_valid
      end
    end
  end

  describe '.destroy' do
    let(:brand) { create(:brand) }

    before(:each) do
      create(:model, brand: brand)
    end

    context 'when referenced by a model' do
      it 'destroy successfully' do
        expect { brand.destroy }.to change { Brand.count }.by(-1)
      end

      it 'destroy dependent models successfully' do
        expect { brand.destroy }.to change { Model.count }.by(-1)
      end
    end
  end
end
