# Modified version of https://github.com/gacha/gacha.id.lv/blob/master/_plugins/i18n_filter.rb

require 'i18n'

I18n.locale = :fr
I18n.backend.load_translations Dir[File.join(File.dirname(__FILE__),'../_locales/*.yml')]

module Jekyll
    module FrdateFilter
        def frdate(input, format=nil)
            I18n.l input, :format => format
        end
    end
end

Liquid::Template.register_filter(Jekyll::FrdateFilter)