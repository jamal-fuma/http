/* Version: MPL 1.1/GPL 2.0
 *
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
 * the License for the specific language governing rights and
 * limitations under the License.
 *
 * The Original Code is libUtility
 *
 * The Initial Developers of the Original Code are FumaSoftware Ltd, and Jamal Natour.
 * Portions created before 1-Jan-2007 00:00:00 GMT by Jamal Natour, are Copyright
 * (C) 2004-2007 Jamal Natour
 *
 * Portions created by FumaSoftware Ltd are Copyright (C) 2009-2010 FumaSoftware
 * Ltd.
 *
 * Portions created by Jamal Natour are Copyright (C) 2009-2010
 * FumaSoftware Ltd and Jamal Natour.
 *
 * All Rights Reserved.
 *
 * Contributor(s): ______________________________________.
 *
 * Alternatively, the contents of this file may be used under the terms
 * of the GNU General Public License Version 2 or later (the "GPL"), in
 * which case the provisions of the GPL are applicable instead of those
 * above. If you wish to allow use of your version of this file only
 * under the terms of the GPL, and not to allow others to use your
 * version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the
 * notice and other provisions required by the GPL. If you do not
 * delete the provisions above, a recipient may use your version of
 * this file under the terms of any one of the MPL or the GPL.
 */
#ifndef FUMA_TEST_HELPER_HPP
#define FUMA_TEST_HELPER_HPP

#include <boost/test/unit_test.hpp>
#include <boost/test/mock_object.hpp>
#include <assert.h>
#include <boost/lexical_cast.hpp>
#include <boost/filesystem.hpp>

#include <iterator>
#include <iostream>
#include <fstream>

#include <vector>
namespace Fuma
{
    namespace Test
    {
        struct Fixture
        {
            public:
                // setup
                Fixture()
                {
                    // setup per test fixture data
                }

                // teardown
                ~Fixture()
		{
		    // cleanup per test fixture data
		}

		// test helpers
		std::string fixture_load(const std::string & fname)
		{
			// glue paths together
			boost::filesystem::path full_path(FIXTURES_DIR);
			full_path /= fname.c_str(); 

			// get a suitable string
			std::string abs_fname = 
				boost::filesystem::canonical(full_path).string();

			uintmax_t size = boost::filesystem::file_size(full_path);

			// read the file into the vector
			std::vector<char>(size).swap(m_data);
			std::ifstream input(abs_fname.c_str());
			input.read(&m_data[0], size);

			return abs_fname;
                }

                // public data the testcases can use
                std::vector<char> m_data;
        };

    } // Fuma::Test namespace
} // Fuma namespace

#endif /* ndef FUMA_TEST_HELPER_HPP */
