from django.db import models

class Category(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name

class Tag(models.Model):
    tag = models.CharField(max_length=50, blank=False)

    def __str__(self):
        return self.tag

class Tea(models.Model):
    code = models.IntegerField(default=0, unique=True)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    description = models.TextField(max_length=1000, blank=False)
    hasTried = models.BooleanField(default=False, blank=True)
    wantToTry = models.BooleanField(default=False, blank=True)
    tasting_notes = models.TextField(max_length=1000, blank=True)
    tags = models.ManyToManyField(Tag, blank=True)
    tea_pic = models.ImageField(upload_to='images/', default=False)

    def __str__(self):
        return f"{self.code} {self.name}"

