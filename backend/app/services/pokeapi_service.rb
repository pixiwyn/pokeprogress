class PokeapiService
    ENDPOINT = "https://pokeapi.co/api/v2"

    def self.get_url(url) 
         HTTParty.get("#{url}")
    end

    def self.get_pokemon(id)
        response = HTTParty.get("#{ENDPOINT}/pokemon/#{id}")
    end


     def self.get_generation(id)
        response = HTTParty.get("#{ENDPOINT}/generation/#{id}")
    end

    def self.get_region(id)
        response = HTTParty.get("#{ENDPOINT}/region/#{id}")
    end
end