local mk_abbreviations = require("abrev").mk_abbreviations

describe("make correct variants", function()
    it("should make basic abbreviation", function()
        local basic = { "creat", "crate" }

        local should_make = {
            CREAT = "CRATE",
            creat = "crate",
            Creat = "Crate"
        }

        local basic_abrev = mk_abbreviations(basic)

        for k, v in pairs(should_make) do
            assert.equal(basic_abrev[k], v)
        end
    end)

    it("should make variants inside {}", function()
        local variants = {
            "{despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}",
            "{despe,sepa}rat{}"
        }

        local should_make = {
            DESPARATOR   = "DESPERATOR",
            DESPARATIONS = "DESPERATIONS",
            desparately  = "desperately",
            Seperates    = "Separates",
            Desparating  = "Desperating",
            DESPARATELY  = "DESPERATELY",
            Seperate     = "Separate",
            Desparations = "Desperations",
            Desparately  = "Desperately",
            SEPERATOR    = "SEPARATOR",
            Seperating   = "Separating",
            seperation   = "separation",
            Seperator    = "Separator",
            Seperately   = "Separately",
            SEPERATE     = "SEPARATE",
            SEPERATING   = "SEPARATING",
            seperates    = "separates",
            seperate     = "separate",
            DESPARATION  = "DESPERATION",
            SEPERATED    = "SEPARATED",
            seperator    = "separator",
            Desparates   = "Desperates",
            SEPERATELY   = "SEPARATELY",
            desparator   = "desperator",
            SEPERATES    = "SEPARATES",
            Desparated   = "Desperated",
            Desparator   = "Desperator",
            desparation  = "desperation",
            DESPARATE    = "DESPERATE",
            Seperated    = "Separated",
            DESPARATES   = "DESPERATES",
            desparations = "desperations",
            seperating   = "separating",
            desparate    = "desperate",
            DESPARATED   = "DESPERATED",
            Desparation  = "Desperation",
            seperated    = "separated",
            SEPERATIONS  = "SEPARATIONS",
            seperately   = "separately",
            Desparate    = "Desperate",
            Seperation   = "Separation",
            DESPARATING  = "DESPERATING",
            seperations  = "separations",
            desparates   = "desperates",
            desparated   = "desperated",
            SEPERATION   = "SEPARATION",
            desparating  = "desperating",
            Seperations  = "Separations",
        }

        local variant_abrev = mk_abbreviations(variants)

        for k, v in pairs(should_make) do
            assert.equal(variant_abrev[k], v)
        end
    end)

    it("should skip leading text not in rhs", function()
        local leading = { "foo{bar,baz}", "{rar,raz}" }

        local should_make = {
            FOOBAR = "RAR",
            foobar = "rar",
            Foobar = "Rar",
            foobaz = "raz",
            Foobaz = "Raz",
            FOOBAZ = "RAZ",
        }

        local leading_abrev = mk_abbreviations(leading)

        for k, v in pairs(should_make) do
            assert.equal(leading_abrev[k], v)
        end
    end)

    it("should skip ending text not in rhs", function()
        local ending = { "{bar,baz}foo", "{rar,raz}" }

        local should_make = {
            barfoo = "rar",
            Bazfoo = "Raz",
            bazfoo = "raz",
            BAZFOO = "RAZ",
            Barfoo = "Rar",
            BARFOO = "RAR",
        }

        local ending_abrev = mk_abbreviations(ending)

        for k, v in pairs(should_make) do
            assert.equal(ending_abrev[k], v)
        end
    end)

    it("should skip leading and ending text not in rhs", function()
        local l_and_e = { "foo{bar,baz}foo", "{rar,raz}" }

        local should_make = {
            foobarfoo = "rar",
            Foobazfoo = "Raz",
            FOOBARFOO = "RAR",
            Foobarfoo = "Rar",
            FOOBAZFOO = "RAZ",
            foobazfoo = "raz",
        }

        local l_and_e_abrev = mk_abbreviations(l_and_e)

        for k, v in pairs(should_make) do
            assert.equal(l_and_e_abrev[k], v)
        end
    end)

    it("should skip unmatching variants in lhs", function()
        local skip = { "foo{bar,baz}{a,b}{c,d}foo", "foo{this,that}foo" }

        local should_make = {
            foobazbcfoo = "foothatfoo",
            Foobazadfoo = "Foothatfoo",
            FOOBARBDFOO = "FOOTHISFOO",
            Foobazbdfoo = "Foothatfoo",
            FOOBARBCFOO = "FOOTHISFOO",
            FOOBAZBCFOO = "FOOTHATFOO",
            foobarbdfoo = "foothisfoo",
            Foobarbcfoo = "Foothisfoo",
            Foobazacfoo = "Foothatfoo",
            foobazadfoo = "foothatfoo",
            foobaracfoo = "foothisfoo",
            FOOBAZBDFOO = "FOOTHATFOO",
            Foobaradfoo = "Foothisfoo",
            Foobaracfoo = "Foothisfoo",
            Foobazbcfoo = "Foothatfoo",
            foobazbdfoo = "foothatfoo",
            FOOBAZACFOO = "FOOTHATFOO",
            foobarbcfoo = "foothisfoo",
            Foobarbdfoo = "Foothisfoo",
            foobazacfoo = "foothatfoo",
            FOOBARADFOO = "FOOTHISFOO",
            FOOBAZADFOO = "FOOTHATFOO",
            FOOBARACFOO = "FOOTHISFOO",
            foobaradfoo = "foothisfoo",
        }

        local skip_abrev = mk_abbreviations(skip)

        for k, v in pairs(should_make) do
            assert.equal(skip_abrev[k], v)
        end
    end)

    it("should skip unmatching variants in lhs and skip ending text not in rhs",
        function()
            local skip = { "foo{bar,baz}{a,b}{c,d}foo", "foo{this,that}" }

            local should_make = {
                foobazbcfoo = "foothat",
                Foobazadfoo = "Foothat",
                FOOBARBDFOO = "FOOTHIS",
                Foobazbdfoo = "Foothat",
                FOOBARBCFOO = "FOOTHIS",
                FOOBAZBCFOO = "FOOTHAT",
                foobarbdfoo = "foothis",
                Foobarbcfoo = "Foothis",
                Foobazacfoo = "Foothat",
                foobazadfoo = "foothat",
                foobaracfoo = "foothis",
                FOOBAZBDFOO = "FOOTHAT",
                Foobaradfoo = "Foothis",
                Foobaracfoo = "Foothis",
                Foobazbcfoo = "Foothat",
                foobazbdfoo = "foothat",
                FOOBAZACFOO = "FOOTHAT",
                foobarbcfoo = "foothis",
                Foobarbdfoo = "Foothis",
                foobazacfoo = "foothat",
                FOOBARADFOO = "FOOTHIS",
                FOOBAZADFOO = "FOOTHAT",
                FOOBARACFOO = "FOOTHIS",
                foobaradfoo = "foothis",
            }

            local skip_abrev = mk_abbreviations(skip)

            for k, v in pairs(should_make) do
                assert.equal(skip_abrev[k], v)
            end
        end)

    it("should skip leading, ending and unmatching variants",
        function()
            local skip = { "foo{bar,baz}{a,b}{c,d}foo", "{this,that}" }

            local should_make = {
                foobazbcfoo = "that",
                Foobazadfoo = "That",
                FOOBARBDFOO = "THIS",
                Foobazbdfoo = "That",
                FOOBARBCFOO = "THIS",
                FOOBAZBCFOO = "THAT",
                foobarbdfoo = "this",
                Foobarbcfoo = "This",
                Foobazacfoo = "That",
                foobazadfoo = "that",
                foobaracfoo = "this",
                FOOBAZBDFOO = "THAT",
                Foobaradfoo = "This",
                Foobaracfoo = "This",
                Foobazbcfoo = "That",
                foobazbdfoo = "that",
                FOOBAZACFOO = "THAT",
                foobarbcfoo = "this",
                Foobarbdfoo = "This",
                foobazacfoo = "that",
                FOOBARADFOO = "THIS",
                FOOBAZADFOO = "THAT",
                FOOBARACFOO = "THIS",
                foobaradfoo = "this",
            }

            local skip_abrev = mk_abbreviations(skip)

            for k, v in pairs(should_make) do
                assert.equal(skip_abrev[k], v)
            end
        end)
end)
