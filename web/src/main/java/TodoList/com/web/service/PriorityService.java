package TodoList.com.web.service;

import TodoList.com.web.model.Priority;
import TodoList.com.web.repository.PriorityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PriorityService {

    @Autowired
    private PriorityRepository priorityRepository;

    public List<Priority> getAllPriorities() {
        return priorityRepository.findAll();
    }
}
