package hello;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class Application {

    @Autowired
    private KafkaTemplate<String, String> kafkaTemplate;
 
    public void sendMessage(String msg) {
        kafkaTemplate.send("mytopic", msg);
    }

    @RequestMapping("/{id}")
    public String home(@PathVariable String id) {
        sendMessage(id);
        return "Hello Docker World" + id;
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

}
