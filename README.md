###  System dependencies
ruby '2.7.1'

### Before using application make SendSMSMessage command file executable

```chmod +x SendSMSMessage```


Example of using application:

run this command in the Linux console

```$ ./SendSMSMessage 'message text' '+49 178 920 10 33' '+38 096 762 65 85'```

```#######################
Sending the SMS message
from - +38 096 762 65 85
to - +49 178 920 10 33
text - message text
```

Run the test suite:

```$ rspec ./spec```
