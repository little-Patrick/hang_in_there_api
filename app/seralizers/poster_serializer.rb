class PosterSerializer 
    def self.format_poster(poster)
        {
            data: [
            id: poster.id.to_s,
            type: "poster",
            attributes: {
                name: poster.name, 
                description: poster.description, 
                price: poster.price, 
                year: poster.year, 
                vintage: poster.vintage, 
                img_url: poster.img_url, 
                }
            ]
        }
    end
end