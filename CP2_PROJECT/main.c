#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct node
{
    char sub[11];
    float time;
    int day;
    int room;
    struct node *next;
    struct node *prev;
}node;
node * add_schedule(node *);
node * del(node *);
node * edit(node *);
int srch(node *);
void print_full(node *);
void print_node(node *);
int txt(node *);
void identify(node *);
int main()
{
    printf("\n\t\t...WELCOME TO CLASSROOM MANAGEMENT SYSTEM...\n\n");
    node *head = NULL;
    int c;
    while(1)
    {
        printf("1.ADD  2.DEL  3.EDIT  4.PRINT  5.COPY TO A TEXT FILE  6.SEARCH  7.EXIT:  ");
        scanf("%d", &c);

        if(c==1)
        {
            head = add_schedule(head);
        }
        else if(c==2)
        {
            head = del(head);
        }
        else if(c==3)
        {
            head = edit(head);
        }
        else if(c==4)
        {
            print_full(head);
        }
        else if(c==5)
        {
            c = txt(head);
            if(c==0)
            {
                printf("Can copy to the file...\n");
            }
            else
                printf("successfully copied to the file...\n");
        }
        else if(c==6)
        {
            identify(head);
        }
        else
        {
            exit(1);
        }
    }
}

void identify(node *head)
{
    node *curr = head;
    printf("What do you want to search ?\n");
    int usr;
    printf("1.Classes & it's details   2.Free classes and their timings: ");
    scanf("%d", &usr);
    if(usr == 1)
    {

        int room;
        int day;
        printf("Enter the classroom you want to know about:  ");
        scanf("%d", &room);
        printf("Enter the day: ");
        scanf("%d", &day);
        printf("On %s ", day == 1 ? "MON" : day == 2 ? "TUE" : day == 3 ? "WED" : day == 4 ? "THU" : "FRI");
        printf("Room: %d\n", room);
        printf("Time\t");
        while(curr!=NULL)
        {
            if(curr->room == room && curr->day == day)
            {
                printf("%.2f-%.2f\t", curr->time, curr->time+1);
            }
            curr = curr->next;
        }
        curr = head;
        printf("\n");
        printf("Subj\t");
        while(curr!=NULL)
        {
            if(curr->room == room && curr->day == day)
            {
                printf("%10s\t", curr->sub);
            }
            curr = curr->next;
        }
        printf("\n");
    }
    else if(usr == 2)
    {
        int day;
        printf("Enter the day: ");
        scanf("%d", &day);
        printf("On %s ", day == 1 ? "MON" : day == 2 ? "TUE" : day == 3 ? "WED" : day == 4 ? "THU" : "FRI");
        printf("free classes:\n");
        printf("Time\t");
        while(curr != NULL)
        {
            if(strcmp(curr->sub, "free")==0)
            {
                printf("%.2f-%.2f\t", curr->time, curr->time+1);
            }
            curr = curr->next;
        }
        curr = head;
        printf("\n");
        printf("Room\t");
        while(curr!=NULL)
        {
            if(strcmp(curr->sub, "free")==0)
            {
                printf("%10d\t", curr->room);
            }
            curr = curr->next;
        }
        printf("\n");
    }
}

int txt(node *head)
{
    FILE *fp = fopen("schedule.txt", "w");
    if(fp == NULL)
        return 0;
    node *curr = head;
    int day, count = 0;

    for (day = 1; day <= 5; day++) {
            if(head == NULL)
            {
                break;
            }
        fprintf(fp, "%s ", day == 1 ? "MON" : day == 2 ? "TUE" : day == 3 ? "WED" : day == 4 ? "THU" : "FRI");

        while (curr != NULL && curr->day == day) {
            fprintf(fp, "\t%.2f-%6.2f ", curr->time, curr->time + 1);
            curr = curr->next;
        }

        fprintf(fp, "\n");

        curr = head;

        if (curr->day != day) {
            while (curr->day != day) {
                if (curr->next == NULL) {
                    break;
                }
                curr = curr->next;
            }
        }

        count++;

        while (curr != NULL && curr->day == day) {
            fprintf(fp, "\t%s, %4d\t ", curr->sub, curr->room);
            curr = curr->next;
        }

        fprintf(fp, "\n\n");
    }

    if (head == NULL) {
        printf("No classes...\n");
    }
    fclose(fp);
    return 1;
}


node * edit(node *head)
{
    int position;
    node *curr = head;
    position = srch(head);
    if(position == 0)
    {
        printf("No such subject exists...\n");
        return head;
    }
    else
    {
        for(int i=0; i<position-1; i++)
        {
            curr = curr->next;
        }
        printf("New Subject: ");
        scanf("%s", curr->sub);
        printf("it's day: ");
        scanf("%d", &curr->day);
        printf("it's time: ");
        scanf("%f", &curr->time);
        printf("it's room: ");
        scanf("%d", &curr->room);
        //print(head);
        return head;
    }
}

node * del(node *head)
{
    node *curr;
    int position = srch(head);
    printf("\nposition: %d\n", position);
    if(position==0)
    {
        printf("Subject does not exist...");
        return head;
    }
    else if(position == 1)
    {
        node *temp = head;
        head = head->next;
        if(head != NULL)
        {
            head->prev = NULL;
        }
        free(temp);
        return head;
    }
    else
    {
        curr = head;
        for(int i=0; i<position-1; i++)
        {
            curr = curr->next;
        }
        if(curr->next == NULL)
        {
            node *temp = curr;
            curr->prev->next = temp->next;
            free(temp);
            return head;
        }
        else
        {
            node *temp = curr;
            curr->prev->next = curr->next;
            curr->next->prev = curr->prev;
            free(temp);
            return head;
        }
    }
}


int srch(node *head)
{
    char sub[11];
    int day, room;
    float time;
    printf("\nEnter the Subject You want to search for:  ");
    scanf("%s", sub);
    printf("Enter it's day:  ");
    scanf("%d", &day);
    printf("Enter it's time:  ");
    scanf("%f", &time);
    printf("Enter the room number: ");
    scanf("%d", &room);
    node *curr = head;
    int pos = 1;

    if (head == NULL) {
        return 0;
    }

    while (curr != NULL) {
        if (curr->day == day && strcmp(curr->sub, sub) == 0 && curr->time == time && curr->room == room) {
            return pos;
        }
        curr = curr->next;
        pos++;
    }

    return 0;
}

node *add_schedule(node *head) {
    node *temp = (node *)malloc(sizeof(node));
    temp->prev = NULL;
    temp->next = NULL;

    printf("Enter the Subject: ");
    scanf("%s", temp->sub);

    printf("Enter the time of the class (just add the lower limit): ");
    scanf("%f", &temp->time);

    printf("Enter the Day:\n1. MON 2. TUE 3. WED 4. THU 5. FRI\n");
    scanf("%d", &temp->day);

    printf("Enter the classroom number: ");
    scanf("%d", &temp->room);

    /*else if(head->day == temp->day && head->time == temp->time && head->room==temp->room)
    {
        printf("There's a clash between the timing of the classes...\n");
        return head;

    }*/

    if (head == NULL || temp->day < head->day || (temp->day == head->day && temp->time < head->time))
    {
        temp->next = head;
        if (head != NULL)
            head->prev = temp;
        head = temp;
    }
    else if(head->day == temp->day && head->time == temp->time && head->room==temp->room)
    {
        printf("There's a clash between the timing of the classes...\nAdd again: \n");
        return head;

    }

    else
    {
        node *curr = head;
        while (curr->next != NULL && (curr->next->day < temp->day || (curr->next->day == temp->day && curr->next->time < temp->time)))
        {
            curr = curr->next;
        }
        temp->next = curr->next;
        if (curr->next != NULL)
            curr->next->prev = temp;
        curr->next = temp;
        temp->prev = curr;
    }

    return head;
}
void print_full(node *head) {
    node *curr = head;
    int day, count = 0;

    for (day = 1; day <= 5; day++) {
            if(head == NULL)
            {
                break;
            }
        printf("%s ", day == 1 ? "MON" : day == 2 ? "TUE" : day == 3 ? "WED" : day == 4 ? "THU" : "FRI");

        while (curr != NULL && curr->day == day) {
            printf("\t%.2f-%6.2f ", curr->time, curr->time + 1);
            curr = curr->next;
        }

        printf("\n");

        curr = head;

        if (curr->day != day) {
            while (curr->day != day) {
                if (curr->next == NULL) {
                    break;
                }
                curr = curr->next;
            }
        }

        count++;

        while (curr != NULL && curr->day == day) {
            printf("\t%s, %4d ", curr->sub, curr->room); // Use field width specifier instead of tab
            curr = curr->next;
        }

        printf("\n\n");
    }

    if (head == NULL) {
        printf("No classes...\n");
    }
}

