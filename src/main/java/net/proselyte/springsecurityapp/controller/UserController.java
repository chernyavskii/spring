package net.proselyte.springsecurityapp.controller;

import net.proselyte.springsecurityapp.model.Room;
import net.proselyte.springsecurityapp.model.User;
import net.proselyte.springsecurityapp.service.RoomService;
import net.proselyte.springsecurityapp.service.SecurityService;
import net.proselyte.springsecurityapp.service.UserService;
import net.proselyte.springsecurityapp.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomCollectionEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.security.Principal;
import java.util.HashSet;
import java.util.Set;

@Controller
public class UserController {

    @Autowired
    private RoomService roomService;

    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private UserValidator userValidator;

    @InitBinder
    protected void initBinder(WebDataBinder binder) throws Exception{
        binder.registerCustomEditor(Set.class,"rooms", new CustomCollectionEditor(Set.class){
            protected Object convertElement(Object element){
                if (element instanceof String) {
                    Set<Room> rooms = new HashSet<>();
                    rooms.add(roomService.findById(Long.parseLong(element.toString())));

                    return rooms;
                }
                return null;
            }
        });
    }

    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String registration(Model model) {
        model.addAttribute("userForm", new User());
/*
        model.addAttribute("listRooms", roomService.listRooms());
*/
        model.addAttribute("listRooms", roomService.listFreeRooms());


        return "registration";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String registration(@ModelAttribute("userForm") @Valid User userForm,
                               BindingResult bindingResult,
                               Model model)
    {
        userValidator.validate(userForm, bindingResult);
        if (bindingResult.hasErrors()) {
            ///////////////////////////////////было только return "registration"
            model.addAttribute("listRooms", roomService.listFreeRooms());
            model.addAttribute("userForm", new User());
            return "registration";
        }
        userService.save(userForm);

        securityService.autoLogin(userForm.getUsername(), userForm.getConfirmPassword());

        return "redirect:/welcome";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(Model model, String error, String logout) {
        if (error != null) {
            model.addAttribute("error", "Username or password is incorrect.");
        }

        if (logout != null) {
            model.addAttribute("message", "Logged out successfully.");
        }
        return "login";
    }

    @RequestMapping(value = {"/", "/welcome"}, method = RequestMethod.GET)
    public String welcome(Model model, Principal principal) {
        model.addAttribute("user", userService.findByUsername(principal.getName()));

        return "welcome";
    }

    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String admin(Model model) {
        model.addAttribute("user", new User());
        model.addAttribute("listUsers", userService.listUsers());

        return "admin";
    }

    @RequestMapping(value = "delete/{id}", method = RequestMethod.GET)
    public String deleteUser(@PathVariable("id") Long id){
        userService.remove(id);

        return "redirect:/admin";
    }

    @RequestMapping(value = "info/{id}",method = RequestMethod.GET)
    public String infoUser(@PathVariable("id") Long id, Model model){
        model.addAttribute("userInfo",userService.findById(id));

        return "forward:/admin";
    }

    @RequestMapping(value = "update/{id}",method = RequestMethod.POST)
    public String test23(@PathVariable("id") Long id, Model model){
        User user = userService.findById(id);
        user.setUsername(user.getUsername());

        return "test";
    }

}
