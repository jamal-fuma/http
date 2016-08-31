// basic_request.cpp
// ~~~~~~~~~~~~~~~~~~~~~~~~
//
// Copyright (c) 2011 Steven Siloti (ssiloti@gmail.com)
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
//
//

#include <ssiloti/http/basic_request.hpp>
#include <ssiloti/http/parsers/request.hpp>
#include <ssiloti/http/generators/request.hpp>

#include <boost/test/unit_test.hpp>
#include <boost/mpl/map/map0.hpp>

#include <iterator>
#include <string>
#include <vector>


#include "TestHelper.hpp"

struct FixtureData
    : public Fuma::Test::Fixture
{
};


BOOST_FIXTURE_TEST_SUITE(BasicSuite, FixtureData)
BOOST_AUTO_TEST_CASE(should_parse_request)
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

BOOST_AUTO_TEST_CASE(should_generate_request)
{
    typedef http::basic_request<boost::mpl::map0<>, std::string> request_t;
    request_t request;

    request.method = "GET";

    std::stringstream sink;

    BOOST_CHECK(request.generate_start_line(std::ostream_iterator<char>(sink)));
    BOOST_CHECK_EQUAL(sink.str(), std::string("GET * HTTP/1.1"));
}

BOOST_AUTO_TEST_CASE(should_match_hello_fixture)
{
    std::string expected = "Hello World\n";
    std::string actual = fixture_load("fixture.txt");

    BOOST_REQUIRE_EQUAL(expected,std::string(m_data.begin(),m_data.end()));
}

BOOST_AUTO_TEST_SUITE_END()
