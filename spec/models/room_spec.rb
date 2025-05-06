require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'properties' do
    it 'has a name property of type String' do
      room = Room.create(name: 'Atrium', description: "entrypoint")
      expect(room.name).to be_a(String)
      room.destroy
    end

    it 'has descritpoin property of type String' do
      room = Room.create(name: 'Bathroom', description: "tile floor. toilet. no toilet paper. sink. shower")
      expect(room.description).to be_a(String)
      room.destroy
    end
  end

  describe 'portals' do
    let(:atrium) { Room.create(name: 'Atrium', description: "entrypoint") }
    let(:bathroom) { Room.create(name: 'Bathroom', description: "tile floor. toilet. no toilet paper. sink. shower") }
    let(:hall) { Room.create(name: 'Hallway', description: "long with many portals") }
    let(:dining) { Room.create(name: 'Dining', description: "table, chairs, carpet") }

    after do
      [atrium, bathroom, hall, dining].each do |room|
        room.destroy rescue nil
      end
    end


    it 'can have many portals' do
      atrium.portals << bathroom
      atrium.portals << hall
      atrium.save
      expect(atrium.portals).to include(bathroom)
      expect(atrium.portals).to include(hall)
    end

    it 'can go both ways' do
      atrium.portals << bathroom
      atrium.save
      expect(atrium.portals).to include(bathroom)
      expect(bathroom.portals).to include(atrium)
    end
  end


end
