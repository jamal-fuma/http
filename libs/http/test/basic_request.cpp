//
// basic_request.cpp
// ~~~~~~~~~~~~~~~~~~~~~~~~
//
// Copyright (c) 2011 Steven Siloti (ssiloti@gmail.com)
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
//
#include <http/basic_request.hpp>
#include <http/parsers/request.hpp>

#include <boost/test/unit_test.hpp>
#include <boost/test/included/unit_test_framework.hpp>

#include <boost/mpl/map/map0.hpp>

#include <string>
#include <vector>

using boost::unit_test::test_suite;

void test_request()
{
    typedef http::basic_request<boost::mpl::map0<>, std::string> request_t;
    request_t request;

    std::string start_line("GET /index.html HTTP/1.1");
    std::string::iterator begin(start_line.begin());

    BOOST_CHECK(request.parse_start_line(begin, start_line.end()));

    BOOST_CHECK_EQUAL(request.method, std::string("GET"));
//    BOOST_CHECK_EQUAL(request.target, http::basic_request<boost::mpl::map0<>, void>::target_t(
    BOOST_CHECK_EQUAL(request.version.major, 1);
    BOOST_CHECK_EQUAL(request.version.minor, 1);
}

test_suite* init_unit_test_suite(int, char*[])
{
  test_suite* test = BOOST_TEST_SUITE("basic_request");
  test->add(BOOST_TEST_CASE(&test_request));
  return test;
}

