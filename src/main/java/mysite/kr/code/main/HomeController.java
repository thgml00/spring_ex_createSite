
package mysite.kr.code.main;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/main")
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, HttpServletRequest request, HttpServletResponse response) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		ModelAndView view = new ModelAndView();
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		view.addObject("serverTime", formattedDate );
		
		view.setViewName("/main/home");
	
		return view;
	}
	
	@RequestMapping(value = "/content.do")
	public ModelAndView getContent(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView view = new ModelAndView();
		view.setViewName("include/contents");
		
		return view;
		
		
	}
	
}
