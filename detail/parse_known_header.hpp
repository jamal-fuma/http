//
// parse_known_header.hpp
// ~~~~~~~~~~~~~~~~~~~~~~
//
// Copyright (c) 2010 Steven Siloti (ssiloti@gmail.com)
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
//
#ifndef HTTP_DETAIL_PARSE_KNOWN_HEADER_HPP
#define HTTP_DETAIL_PARSE_KNOWN_HEADER_HPP

#include <boost/logic/tribool.hpp>
#include <string>

namespace http {
namespace detail {

struct parse_known_header
{
	// Add we really need is a bool that default constructs to false.
	// I used boost::tribool beause I'm lazy.
	typedef boost::tribool result_type;

	parse_known_header(std::string value)
		: value_(value) {}

	template <typename Header>
	result_type operator()(Header header) const
	{
		header.second.parse(value_);
		return true;
	}

	const std::string& value_;
};

}
}

#endif
