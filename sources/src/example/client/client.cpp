//
// client.cpp
// ~~~~~~~~~~~~~~~~~~~~~~~~
//
// Copyright (c) 2011 Steven Siloti (ssiloti@gmail.com)
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
//

#include <ssiloti/http/parsers/headers.hpp>
#include <ssiloti/http/generators/headers.hpp>

#include <ssiloti/http/parsers/message.hpp>
#include <ssiloti/http/parsers/response.hpp>
#include <ssiloti/http/generators/message.hpp>
#include <ssiloti/http/generators/request.hpp>

#include <ssiloti/http/generators/string_message.hpp>
#include <ssiloti/http/parsers/string_message.hpp>

#include <ssiloti/http/headers.hpp>

#include <ssiloti/http/uri_ops.hpp>
#include <ssiloti/uri/basic_uri.ipp>

#include <iostream>

void handle_response(const boost::system::error_code & error, boost::shared_ptr<http::string_response> res)
{
    std::cout << res->body;
}

int main(int argc, char ** argv)
{
    if(argc > 1)
    {
        boost::asio::io_service service;
        http::async_request<std::string>(service, "GET", argv[1], handle_response);
        service.run();
    }
    return 0;
}
