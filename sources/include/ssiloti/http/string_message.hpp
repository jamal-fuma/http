//
// string_message.hpp
// ~~~~~~~~~~~~~~~~~~~~~~~~
//
// Copyright (c) 2011 Steven Siloti (ssiloti@gmail.com)
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
//
#ifndef HTTP_STRING_MESSAGES_HPP
#define HTTP_STRING_MESSAGES_HPP

#include <ssiloti/http/basic_request.hpp>
#include <ssiloti/http/basic_response.hpp>
#include <ssiloti/http/headers.hpp>

#include <vector>

namespace http
{

    typedef basic_request<headers::map, std::string> string_request;
    typedef basic_response<headers::map, std::string> string_response;

}

#endif
