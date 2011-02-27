#ifndef URI_GRAMMAR_HPP
#define URI_GRAMMAR_HPP

// Copyright 2009 Dean Michael Berris, Jeroen Habraken.
// Copyright 2011 Steven Siloti.
// Distributed under the Boost Software License, Version 1.0.
// (See accompanying file LICENSE_1_0.txt or copy at
// http://www.boost.org/LICENSE_1_0.txt)

#include <uri/basic_uri.hpp>

#include <uri/components.hpp>


namespace uri {

namespace qi = boost::spirit::qi;

template <typename Iterator, class String>
struct grammar
    : boost::spirit::qi::grammar<Iterator, basic_uri<String>()>
{
    typedef String string_type;

    grammar() : grammar::base_type(start, "uri")
    {
        uri %=
                scheme >> ':'
            >>  hier_part
            >>  -('?' >> query)
            >>  -('#' >> fragment);

        start %= uri.alias();
    }

    scheme_grammar<Iterator, string_type> scheme;
    hier_part_grammar<Iterator, string_type> hier_part;
    query_grammar<Iterator, string_type> query;
    fragment_grammar<Iterator, string_type> fragment;

    // start rule of grammar
    boost::spirit::qi::rule<Iterator, basic_uri<string_type>()> start;

    // actual uri parser
    boost::spirit::qi::rule<Iterator, typename detail::basic_uri_tuple<string_type>::type()> uri;


};

} // namespace uri

#endif // ifdef URI_GRAMMAR_HPP
