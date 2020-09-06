
# This script is made for generating relational database INSERT statements to migrate sectors from TEST.html to API database.
# Some primitive text processing is done by text editor
# The printout of this script is suitable to run in database console

rawSectors = [
    "Manufacturing",
    "&nbsp;Construction materials",
    "&nbsp;Electronics and Optics",
    "&nbsp;Food and Beverage",
    "&nbsp;&nbsp;Bakery & confectionery products",
    "&nbsp;&nbsp;Beverages",
    "&nbsp;&nbsp;Fish & fish products",
    "&nbsp;&nbsp;Meat & meat products",
    "&nbsp;&nbsp;Milk & dairy products",
    "&nbsp;&nbsp;Other",
    "&nbsp;&nbsp;Sweets & snack food",
    "&nbsp;Furniture",
    "&nbsp;&nbsp;Bathroom/sauna",
    "&nbsp;&nbsp;Bedroom",
    "&nbsp;&nbsp;Children’s room",
    "&nbsp;&nbsp;Kitchen",
    "&nbsp;&nbsp;Living room",
    "&nbsp;&nbsp;Office",
    "&nbsp;&nbsp;Other (Furniture)",
    "&nbsp;&nbsp;Outdoor",
    "&nbsp;&nbsp;Project furniture",
    "&nbsp;Machinery",
    "&nbsp;&nbsp;Machinery components",
    "&nbsp;&nbsp;Machinery equipment/tools",
    "&nbsp;&nbsp;Manufacture of machinery",
    "&nbsp;&nbsp;Maritime",
    "&nbsp;&nbsp;&nbsp;Aluminium and steel workboats",
    "&nbsp;&nbsp;&nbsp;Boat/Yacht building",
    "&nbsp;&nbsp;&nbsp;Ship repair and conversion",
    "&nbsp;&nbsp;Metal structures",
    "&nbsp;&nbsp;Other",
    "&nbsp;&nbsp;Repair and maintenance service",
    "&nbsp;Metalworking",
    "&nbsp;&nbsp;Construction of metal structures",
    "&nbsp;&nbsp;Houses and buildings",
    "&nbsp;&nbsp;Metal products",
    "&nbsp;&nbsp;Metal works",
    "&nbsp;&nbsp;&nbsp;CNC-machining",
    "&nbsp;&nbsp;&nbsp;Forgings, Fasteners",
    "&nbsp;&nbsp;&nbsp;Gas, Plasma, Laser cutting",
    "&nbsp;&nbsp;&nbsp;MIG, TIG, Aluminum welding",
    "&nbsp;Plastic and Rubber",
    "&nbsp;&nbsp;Packaging",
    "&nbsp;&nbsp;Plastic goods",
    "&nbsp;&nbsp;Plastic processing technology",
    "&nbsp;&nbsp;&nbsp;Blowing",
    "&nbsp;&nbsp;&nbsp;Moulding",
    "&nbsp;&nbsp;&nbsp;Plastics welding and processing",
    "&nbsp;&nbsp;Plastic profiles",
    "&nbsp;Printing",
    "&nbsp;&nbsp;Advertising",
    "&nbsp;&nbsp;Book/Periodicals printing",
    "&nbsp;&nbsp;Labelling and packaging printing",
    "&nbsp;Textile and Clothing",
    "&nbsp;&nbsp;Clothing",
    "&nbsp;&nbsp;Textile",
    "&nbsp;Wood",
    "&nbsp;&nbsp;Other (Wood)",
    "&nbsp;&nbsp;Wooden building materials",
    "&nbsp;&nbsp;Wooden houses",
    "Other",
    "&nbsp;Creative industries",
    "&nbsp;Energy technology",
    "&nbsp;Environment",
    "Service",
    "&nbsp;Business services",
    "&nbsp;Engineering",
    "&nbsp;Information Technology and Telecommunications",
    "&nbsp;&nbsp;Data processing, Web portals, E-marketing",
    "&nbsp;&nbsp;Programming, Consultancy",
    "&nbsp;&nbsp;Software, Hardware",
    "&nbsp;&nbsp;Telecommunications",
    "&nbsp;Tourism",
    "&nbsp;Translation services",
    "&nbsp;Transport and Logistics",
    "&nbsp;&nbsp;Air",
    "&nbsp;&nbsp;Rail",
    "&nbsp;&nbsp;Road",
    "&nbsp;&nbsp;Water",
]

print('# Migrate sectors')

sqlFormat = "INSERT INTO sector (id, parent_id, name) VALUES (%i, %s, '%s');"

sectorId = 1
depthMap = []

for rawSector in rawSectors:
    depth = rawSector.count("&nbsp;")
    depthMap.insert(depth, sectorId)

    if depth == 0:
        parentId = 'null'
    else:
        parentId = depthMap[(depth-1)]

    print(sqlFormat % (sectorId, parentId, rawSector.replace("&nbsp;", "")))

    sectorId+=1

print("COMMIT;")
print("")
print('# Update primary key auto increment value after migration')
print("ALTER TABLE sector AUTO_INCREMENT = %i;" % sectorId)