db.zips.aggregate([
    {$project:
        {
            first_char: { $substr: ["$city", 0, 1] },
        }
    }, 

    { $match : { first_char : /^[0-9]/ }}

]).forEach(function(x){printjson(x)})
