package net.proselyte.springsecurityapp.controller;

import net.proselyte.springsecurityapp.model.*;
import net.proselyte.springsecurityapp.service.*;
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

    @Autowired
    private PayService payService;

    @Autowired
    private ControlService controlService;

    @Autowired
    private DutyService dutyService;

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

        binder.registerCustomEditor(Set.class,"users", new CustomCollectionEditor(Set.class){
            protected Object convertElement(Object element){
                element.getClass();
                if (element instanceof String) {
                    Set<User> users = new HashSet<>();
                    users.add(userService.findById(Long.parseLong(element.toString())));

                    return users;
                }
                return null;
            }
        });
    }

    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String registration(Model model) {
        model.addAttribute("userForm", new User());
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
        model.addAttribute("payForm", new Pay());
        model.addAttribute("dutyForm", new Duty());

        return "welcome";
    }

    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String admin(Model model) {
        model.addAttribute("user", new User());
        model.addAttribute("listUsers", userService.listUsers());
        model.addAttribute("listRooms", roomService.listRooms());
        model.addAttribute("listPays", payService.listPays());
        model.addAttribute("listDuties", dutyService.listDuties());


        model.addAttribute("dutyForm", new Duty());
        model.addAttribute("controlForm", new Control());

        model.addAttribute("countFreeRooms", roomService.getCountFreeRooms());
        return "admin";
    }

    @RequestMapping(value = "admin/users/delete/{id}", method = RequestMethod.GET)
    public String deleteUser(@PathVariable("id") Long id){
        userService.remove(id);

        return "redirect:/admin";
    }

    @RequestMapping(value = "users/user/{id}",method = RequestMethod.GET)
    public String infoUser(@PathVariable("id") Long id, Model model){
        model.addAttribute("userProfile",userService.findById(id));

        return "userProfile";
    }

    @RequestMapping(value = "/users/pay",method = RequestMethod.POST)
    public String pay(@ModelAttribute("payForm") @Valid Pay payForm,
                      BindingResult bindingResult, Principal principal){

        User thisUser = userService.findByUsername(principal.getName());
        payService.save(payForm, thisUser);
        return "redirect:/users/pay";
    }

    @RequestMapping(value = "/users/duty/{id}", method = RequestMethod.POST)
    public String newDuty(@ModelAttribute("dutyForm") @Valid Duty dutyForm,
                          BindingResult bindingResult,@PathVariable("id") Long id, Principal principal){

        dutyService.testF(id, dutyForm);

        return "redirect:/users/duty";
    }

    @RequestMapping(value = "/users/duty", method = RequestMethod.GET)
    public String getDutiest(Model model, Principal principal){
        model.addAttribute("user", userService.findByUsername(principal.getName()));
        model.addAttribute("dutyForm", new Duty());

        return "duties";
    }

    @RequestMapping(value = "/users/duty/r/{id}", method = RequestMethod.GET)
    public String setReceiveStatus(@PathVariable("id") Long id,Principal principal, Model model){
        dutyService.setReceiveStatus(id);

        return "redirect:/users/duty";
    }

    @RequestMapping(value = "/users", method = RequestMethod.GET)
    public String getRoomUsers(Model model, Principal principal){
        model.addAttribute("user", userService.findByUsername(principal.getName()));

        return "roomUsers";
    }

    @RequestMapping(value = "/users/pay", method = RequestMethod.GET)
    public String getPay(Model model, Principal principal){
        model.addAttribute("user", userService.findByUsername(principal.getName()));
        model.addAttribute("payForm", new Pay());

        return "pay";
    }

    @RequestMapping(value = "/admin/pay/s/{id}", method = RequestMethod.GET)
    public String setToSuccessStatus(@PathVariable("id") Long id){
        payService.setToSuccess(id);

        return "redirect:/admin";
    }

    @RequestMapping(value = "/admin/pay/f/{id}", method = RequestMethod.GET)
    public String setToFailStatus(@PathVariable("id") Long id){
        payService.setToFail(id);

        return "redirect:/admin";
    }

    @RequestMapping(value = "/admin/duty/add", method = RequestMethod.POST)
    public String addNewDuty(@ModelAttribute("dutyForm") @Valid Duty dutyForm,
                             BindingResult bindingResult, Model model){
        dutyService.addNewDuty(dutyForm);
        return "redirect:/admin";
    }

    @RequestMapping(value = "/admin/duty/f/{id}", method = RequestMethod.GET)
    public String toFailStatus(@PathVariable("id") Long id){
        dutyService.toFailStatus(id);

        return "redirect:/admin";
    }

    @RequestMapping(value = "/admin/duty/s/{id}", method = RequestMethod.GET)
    public String toSuccessStatus(@PathVariable("id") Long id){
        dutyService.toSuccessStatus(id);

        return "redirect:/admin";
    }

    @RequestMapping(value = "/admin/control/add", method = RequestMethod.POST)
    public String addNewControl(@ModelAttribute("controlForm") @Valid Control controlForm,
                             BindingResult bindingResult, Model model){
        controlService.addNewControl(controlForm);

        return "redirect:/admin";
    }







}
