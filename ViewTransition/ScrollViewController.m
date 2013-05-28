/*****************************************************************************
 *
 * FILE:	ScrollViewController.m
 * DESCRIPTION:	ViewTransition: Scroll View Controller with UIPageControl
 * DATE:	Tue, May 28 2013
 * UPDATED:	Tue, May 28 2013
 * AUTHOR:	Kouichi ABE (WALL) / 阿部康一
 * E-MAIL:	kouichi@MagickWorX.COM
 * URL:		http://www.MagickWorX.COM/
 * COPYRIGHT:	(c) 2013 阿部康一／Kouichi ABE (WALL), All rights reserved.
 * LICENSE:
 *
 *  Copyright (c) 2013 Kouichi ABE (WALL) <kouichi@MagickWorX.COM>,
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions
 *  are met:
 *
 *   1. Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *
 *   2. Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *
 *   THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 *   ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 *   THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 *   PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
 *   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 *   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 *   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 *   INTERRUPTION)  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 *   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 *   THE POSSIBILITY OF SUCH DAMAGE.
 *
 * $Id: ScrollViewController.m,v 1.2 2013/01/22 15:23:51 kouichi Exp $
 *
 *****************************************************************************/

#import "ScrollViewController.h"
#import "ContentsViewController.h"

#define	kPageControlHeight	12.0

@interface ScrollViewController () <UIScrollViewDelegate>
{
@private
  UIScrollView *	_scrollView;
  UIPageControl *	_pageControl;
  BOOL			_pageControlUsed;
}
@property (nonatomic,retain) UIScrollView *	scrollView;
@property (nonatomic,retain) UIPageControl *	pageControl;
@property (nonatomic,assign) BOOL		pageControlUsed;
@end

@implementation ScrollViewController

-(id)init
{
  self = [super init];
  if (self) {
    self.title = NSLocalizedString(@"ScrollView", @"");
  }
  return self;
}

-(void)dealloc
{
  [_scrollView release];
  [_pageControl release];
  [super dealloc];
}

-(void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)viewDidLoad
{
  [super viewDidLoad];

  CGRect	frame = self.view.bounds;
  frame.size.height  -= [[self navigationController]
			  navigationBar].bounds.size.height;

  CGFloat	x = 0.0f;
  CGFloat	y = 0.0f;
  CGFloat	w = frame.size.width;
  CGFloat	h = frame.size.height;

  UIScrollView *	scrollView;
  scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y, w, h)];
  scrollView.delegate		= self;
  scrollView.pagingEnabled	= YES;
  scrollView.scrollsToTop	= NO;
  scrollView.backgroundColor	= [UIColor scrollViewTexturedBackgroundColor];
  scrollView.showsHorizontalScrollIndicator	= NO;
  scrollView.showsVerticalScrollIndicator	= NO;
  [self.view addSubview:scrollView];
  self.scrollView = scrollView;
  [scrollView release];


  x	= 0.0f;
  y	= frame.size.height - kPageControlHeight - 4.0f;
  w	= frame.size.width;
  h	= kPageControlHeight;
  UIPageControl *	pageControl;
  pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(x, y, w, h)];
  pageControl.backgroundColor	= [UIColor clearColor];
  pageControl.autoresizingMask	= UIViewAutoresizingFlexibleWidth;
  pageControl.numberOfPages	= 10;
  pageControl.currentPage	= 0;
  pageControl.defersCurrentPageDisplay	= YES;
  [pageControl addTarget:self
	       action:@selector(changePage:)
	       forControlEvents:UIControlEventValueChanged];
  [pageControl setHidesForSinglePage:YES];
  [self.view addSubview:pageControl];
  self.pageControl = pageControl;
  [pageControl release];
  self.pageControlUsed = NO;

  [self loadScrollViewWithPage:self.pageControl.currentPage];
}

/*****************************************************************************/

#pragma mark UIPageControl action
-(void)changePage:(UIPageControl *)pageControl
{
  self.pageControlUsed	= YES;

  NSInteger	page = [pageControl currentPage];

  [self loadScrollViewWithPage:(page - 1)];
  [self loadScrollViewWithPage:page];
  [self loadScrollViewWithPage:(page + 1)];

  [pageControl updateCurrentPageDisplay];

  CGRect	frame = self.scrollView.frame;
  frame.origin.x = frame.size.width * page;
  [self.scrollView scrollRectToVisible:frame animated:YES];
}

/*****************************************************************************/

-(void)loadScrollViewWithPage:(NSInteger)page
{
  if (page < 0) { return; }
  if (page >= self.pageControl.numberOfPages) { return; }

  CGRect	frame	= self.scrollView.frame;
  CGFloat	width	= frame.size.width;
  CGFloat	height	= frame.size.height;

  NSArray *	colors	= @[
    [UIColor grayColor],
    [UIColor redColor],
    [UIColor greenColor],
    [UIColor blueColor],
    [UIColor cyanColor],
    [UIColor yellowColor],
    [UIColor magentaColor],
    [UIColor orangeColor],
    [UIColor purpleColor],
    [UIColor brownColor],
    [UIColor lightGrayColor],
    [UIColor darkGrayColor]
  ];

  NSArray *	subviews = [self.scrollView subviews];
  if (!(page < [subviews count])) {
    self.scrollView.contentSize	= CGSizeMake(width * self.pageControl.numberOfPages, height);

    frame.origin.x = width * page;
    frame.origin.y = 0.0f;

    UIView *	view;
    view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [colors objectAtIndex:(page % colors.count)];
    [self.scrollView addSubview:view];
    [view release];
  }
}

-(void)scrollToPage:(NSInteger)page
{
  [self loadScrollViewWithPage:page];

  CGRect	frame = self.scrollView.frame;
  frame.origin.x = frame.size.width * page;
  [self.scrollView scrollRectToVisible:frame animated:YES];
  self.pageControl.currentPage = page;
}

#pragma mark UIScrollViewDelegate
// any offset changes
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  CGFloat	width	= scrollView.frame.size.width;
  NSInteger	page	= (NSInteger)floorf((scrollView.contentOffset.x - width * 0.5f) / width) + 1;

  [self loadScrollViewWithPage:(page + 1)];

  self.pageControl.currentPage	= page;

  self.pageControlUsed	= NO;
}

#if	0
#pragma mark UIScrollViewDelegate
// called on finger up as we are moving
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
}

#pragma mark UIScrollViewDelegate
// called when scroll view grinds to a halt
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  CGFloat	width	= scrollView.frame.size.width;
  NSInteger	page	= (NSInteger)floorf((scrollView.contentOffset.x - width * 0.5) / width) + 1;

  [self loadScrollViewWithPage:page];

  self.pageControl.currentPage	= page;

  self.pageControlUsed	= NO;
}
#endif

/*****************************************************************************/


@end
