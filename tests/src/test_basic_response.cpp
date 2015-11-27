//
// basic_response.cpp
// ~~~~~~~~~~~~~~~~~~~~~~~~
//
// Copyright (c) 2011 Steven Siloti (ssiloti@gmail.com)
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
//
#include <ssiloti/http/basic_response.hpp>
#include <ssiloti/http/parsers/response.hpp>
#include <ssiloti/http/generators/response.hpp>

#include <boost/test/unit_test.hpp>
#include <boost/mpl/map/map0.hpp>

#include <sstream>
#include <iterator>

#include "TestHelper.hpp"

struct FixtureData
    : public Fuma::Test::Fixture
{
};

BOOST_FIXTURE_TEST_SUITE(BasicSuite, FixtureData)

BOOST_AUTO_TEST_CASE(should_parse_response)
{
    http::basic_response<boost::mpl::map0<>, std::string> response;

    std::string status_line("HTTP/1.1 200 OK");
    std::string::iterator begin(status_line.begin());

    BOOST_CHECK(response.parse_start_line(begin, status_line.end()));

    BOOST_CHECK_EQUAL(response.version.major, 1);
    BOOST_CHECK_EQUAL(response.version.minor, 1);
    BOOST_CHECK_EQUAL(response.status, http::status_ok);
    BOOST_CHECK_EQUAL(response.reason, std::string("OK"));
}

BOOST_AUTO_TEST_CASE(should_generate_response)
{
    http::basic_response<boost::mpl::map0<>, std::string> response;

    response.version.major = response.version.minor = 1;
    response.status = http::status_ok;
    response.reason = "OK";

    std::stringstream output;

    BOOST_CHECK(response.generate_start_line(std::ostream_iterator<char>(output)));

    BOOST_CHECK_EQUAL(output.str(), std::string("HTTP/1.1 200 OK\r\n"));
}

BOOST_AUTO_TEST_CASE(should_match_hello_fixture)
{
    std::string expected = "Hello World\n";
    std::string actual = fixture_load("fixture.txt");

    BOOST_REQUIRE_EQUAL(expected,std::string(m_data.begin(),m_data.end()));
}

BOOST_AUTO_TEST_SUITE_END()
