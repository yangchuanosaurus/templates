# TemplateCli
Command line tools for support personal development

## commands of template-cli

### init current project as a template
```template-cli init RandomCaseStringTemplate 1.0.0```

### publish to template center
```template-cli publish```

### use a template from center
specific the version
```template-cli use RandomCaseStringTemplate 1.0.0```

the latest version
```template-cli use RandomCaseStringTemplate```

### remove a template reference
```template-cli remove RandomCaseStringTemplate```

### upgrade a template reference
```template-cli upgrade RandomCaseStringTemplate```

## Template Vocabulary
We using a vocabulary to expose the template to consumer.
It's divide to 2 kind of vocabulary
- Template vocabulary
* used for expose a template code
- Consumer template vocabulary
* used for how to consumer the template vocabulary

### Copy
Copy is a general process to copy folder array into target
* make sure you should define the target path from consumer side

### Dependencies
The tempalte code may has some dependencies, by gradle, maven, cocoa-pod, or other dependency system.

Which means you should define the dependency system in `template_define.yml`, then consumer could know how to add the dependencies into its source code.