class LostObject < ActiveRecord::Base
  has_attached_file :image,
                    styles: { thumb: ["100x100#", :jpg],
                              original: ["500x500>", :jpg] },
                    convert_options: { thumb: "-strip",
                                       original: "-strip" },
                    url: "/system/:hash.:extension",
                    hash_secret: "5bb726e0749f58e322dd5d3d6579e3e5a75"
  validates_attachment :image, presence: true,
                       content_type: { content_type: ["image/jpeg",
                                                      "image/gif",
                                                      "image/png"] },
                       size: { in: 0..500.kilobytes }
end
